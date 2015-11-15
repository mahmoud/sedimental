# user customization
# TODO: document other hooks

import os

import yaml

print ' - custom module loaded.'


def chert_post_load(chert_obj):
    print ' - post_load hook: %s entries loaded' % len(chert_obj.entries)
    _autotag_entries(chert_obj)

    for e in chert_obj.draft_entries:
        if e.headers.get('entry_root'):
            continue
        if '/esp/' not in e.source_path or e.entry_root.startswith('esp/'):
            continue
        base_name, _ = os.path.splitext(os.path.split(e.source_path)[-1])
        e.headers['entry_root'] = 'esp/' + base_name


def chert_pre_audit(chert_obj):
    # exceptions are automatically caught and logged
    # just enable debug mode to see issues
    raise ValueError('something went awry')


def _autotag_entries(chert_obj):
    # called by post_load
    for entry in chert_obj.entries:
        rel_path = os.path.relpath(entry.source_path, chert_obj.entries_path)
        rel_path, entry_filename = os.path.split(rel_path)
        new_tags = [p.strip() for p in rel_path.split('/') if p.split()]
        for tag in new_tags:
            if tag not in entry.tags:
                entry.tags.append(tag)

    chert_obj._rebuild_tag_map()

    return
