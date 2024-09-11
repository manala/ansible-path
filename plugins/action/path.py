from __future__ import annotations

from ansible.errors import AnsibleActionFail
from ansible.plugins.action import ActionBase
from ansible.utils.display import Display
from ansible.utils.vars import combine_vars

display = Display()


class ActionModule(ActionBase):
    '''Handle path'''

    def run(self, tmp=None, task_vars=None):

        result = super(ActionModule, self).run(tmp, task_vars)

        validation, args = self.validate_argument_spec(
            argument_spec={
                'path': {'type': 'path', 'required': True},
                'state': {'type': 'str', 'choices': ['present', 'absent', 'file'], 'default': 'present'},
                'content': {'type': 'str'},
                'template': {'type': 'path'},
                'vars': {'type': 'dict', 'default': {}},
                'user': {'type': 'str'},
                'group': {'type': 'str'},
                'mode': {'type': 'raw'},
                'validate': {'type': 'str'},
            },
            mutually_exclusive=(
                ['content', 'template'],
            ),
        )

        if args['state'] == 'absent':
            display.v('Use "ansible.builtin.file" to ensure "%s" is absent.' % args['path'])
            result.update(
                self._execute_module(
                    module_name='ansible.builtin.file',
                    module_args={
                        'path': args['path'],
                        'state': args['state'],
                    },
                    task_vars=task_vars,
                )
            )
        elif (args['state'] in ['present', 'file']) and args['content'] is not None:
            display.v('Use "ansible.builtin.copy" to ensure "%s" content.' % args['path'])
            task = self._task.copy()
            task.args = {
                'dest': args['path'],
                'content': args['content'],
                'owner': args['user'],
                'group': args['group'],
                'mode': args['mode'],
                'validate': args['validate'],
            }
            result.update(
                self._shared_loader_obj.action_loader.get(
                    'ansible.builtin.copy',
                    task=task,
                    connection=self._connection,
                    play_context=self._play_context,
                    loader=self._loader,
                    templar=self._templar,
                    shared_loader_obj=self._shared_loader_obj,
                ).run(task_vars=combine_vars(task_vars, args['vars']))
            )
        elif (args['state'] in ['present', 'file']) and args['template']:
            display.v('Use "ansible.builtin.template" to ensure "%s" template.' % args['path'])
            task = self._task.copy()
            task.args = {
                'src': args['template'],
                'dest': args['path'],
                'owner': args['user'],
                'group': args['group'],
                'mode': args['mode'],
                'validate': args['validate'],
            }
            result.update(
                self._shared_loader_obj.action_loader.get(
                    'ansible.builtin.template',
                    task=task,
                    connection=self._connection,
                    play_context=self._play_context,
                    loader=self._loader,
                    templar=self._templar,
                    shared_loader_obj=self._shared_loader_obj,
                ).run(task_vars=combine_vars(task_vars, args['vars']))
            )
        elif args['state'] == 'file':
            raise AnsibleActionFail('one of the following is required: content, template')
        elif args['state'] == 'present':
            display.v('Use "ansible.builtin.file" to ensure "%s" is a directory.' % args['path'])
            result.update(
                self._execute_module(
                    module_name='ansible.builtin.file',
                    module_args={
                        'path': args['path'],
                        'state': 'directory',
                        'owner': args['user'],
                        'group': args['group'],
                        'mode': args['mode'],
                    },
                    task_vars=task_vars,
                )
            )

        return result
