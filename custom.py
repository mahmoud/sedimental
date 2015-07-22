# user customization
# TODO: document other hooks

import os

import yaml

print ' - custom module loaded.'


def chert_post_load(chert_obj):
    try:
        return _chert_post_load(chert_obj)
    except Exception as e:
        import pdb;pdb.post_mortem()
        raise


class StringLoaded(Exception):
    pass


def _chert_post_load(chert_obj):
    print ' - post_load hook: %s entries loaded' % len(chert_obj.entries)
    _autotag_entries(chert_obj)

    # multidoc parser
    ret = []
    f = open(chert_obj.entries_path + '/pages/podcasts.yaml')
    content = f.read()
    tokens = content.split('---\n')
    was_yaml = True
    for t in tokens:
        try:
            item = yaml.load(t)
            if isinstance(item, str):
                raise StringLoaded()
            was_yaml = True
        except (StringLoaded, yaml.YAMLError):
            if not was_yaml:
                # if between two markdown parts, assume the divider is
                # part of content and put it back.
                ret[-1] = '---\n'.join([ret[-1], t])
            else:
                was_yaml = False
                ret.append(t)
        else:
            ret.append(item)
    print [type(t) for t in ret]
    print len(tokens), len(ret)

    ctx = {}
    parts = ctx['parts'] = []
    for part in ret:
        if part is None:
            continue
        if isinstance(part, basestring):
            rendered_content = chert_obj.md_renderer.convert(part)
            chert_obj.md_renderer.reset()
            parts.append({'rendered_content': rendered_content})
        else:
            parts.append(part)
    #chert_obj.html_renderer.register_path('./list.html', name='list.html')
    #html = chert_obj.html_renderer.render('list.html', ctx)
    #with open('site/tmp.html', 'wb') as f:
    #    f.write(html)
    #import pdb;pdb.set_trace()


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
