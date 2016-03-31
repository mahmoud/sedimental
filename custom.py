# user customization
# TODO: document other hooks

import os
import sys
sys.path.append(os.path.abspath(os.path.dirname(__file__)) + '/lib')

import yaml

print ' - custom module loaded.'


def chert_post_load(chert_obj):
    print ' - post_load hook: %s entries loaded' % len(chert_obj.entries)
    print ' - post_load hook: %s drafts loaded' % len(chert_obj.draft_entries)
    _autotag_entries(chert_obj)

    for e in chert_obj.draft_entries:
        if e.headers.get('entry_root'):
            continue
        if '/esp/' not in e.source_path or e.entry_root.startswith('esp/'):
            continue
        base_name, _ = os.path.splitext(os.path.split(e.source_path)[-1])
        e.headers['entry_root'] = 'esp/' + base_name


def is_potweet(sentence):
    s = sentence
    if not 60 < len(s) < 130:
        return False
    # TODO: regex for punc, right now throws out sentences starting
    # with e.g., "something"
    if s.lower().startswith(('and', 'but', 'so')):
        return False
    return True

def chert_post_render(chert_obj):

    from crisco import en_split_sentences
    from boltons.strutils import html2text

    for e in chert_obj.draft_entries:
        if e.title != 'Simple Statistics for Systems':
            continue

        text = html2text(e.entry_html)
        sentences = en_split_sentences(text)
        count = 0
        for s in sentences:
            if not is_potweet(s):
                continue
            count += 1
            print count, '-', s


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
