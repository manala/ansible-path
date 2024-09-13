from __future__ import absolute_import, division, print_function
__metaclass__ = type

import os.path

from ansible.errors import AnsibleFilterError


def join(elements, *paths):
    if not isinstance(elements, list):
        raise AnsibleFilterError('join first parameter expects a list of dictionary but was given a %s' % type(elements))

    for element in elements:
        element['path'] = os.path.join(*(*paths, element['path']))

    return elements


class FilterModule(object):
    ''' Manala join jinja2 filters '''

    def filters(self):
        filters = {
            'join': join,
        }

        return filters
