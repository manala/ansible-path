from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import unittest
from plugins.filter.join import join

from ansible.errors import AnsibleFilterError


class TestJoin(unittest.TestCase):

    def test_uncorrect_first_parameter(self):
        with self.assertRaises(AnsibleFilterError) as error:
            join("NotGood", "/tmp")
        self.assertEqual("join first parameter expects a list of dictionary but was given a <class 'str'>", str(error.exception))

    def test_path(self):
        self.assertEqual([
            {"path": "/tmp/foo"},
            {"path": "/tmp/foo/bar"}
        ], join([
            {"path": "foo"},
            {"path": "foo/bar"}
        ], "/tmp"))

    def test_paths(self):
        self.assertEqual([
            {"path": "/tmp/service/foo"},
            {"path": "/tmp/service/foo/bar"}
        ], join([
            {"path": "foo"},
            {"path": "foo/bar"}
        ], "/tmp", "service"))
