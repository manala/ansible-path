# Ansible Collection - manala.path

[![homepage][image]][url]

[image]: https://raw.githubusercontent.com/manala/resources/main/logo.svg
[url]: https://www.manala.io/ "manala.io"

**The flexible, robust, and web oriented toolbox for Ansible !**

![Tests](https://img.shields.io/github/checks-status/manala/ansible-path/main)

## Using this collection

### Installing the Collection from Ansible Galaxy

Before using this collection, you need to install it with the Ansible Galaxy command-line tool:
```shell
ansible-galaxy collection install manala.path
```

You can also include it in a `requirements.yml` file and install it with `ansible-galaxy collection install -r requirements.yml`, using the format:
```yaml
---
collections:
  - name: manala.path
```

Note that if you install the collection from Ansible Galaxy, it will not be upgraded automatically when you upgrade the `ansible` package. To upgrade the collection to the latest available version, run the following command:
```shell
ansible-galaxy collection install manala.path --upgrade
```

You can also install a specific version of the collection, for example, if you need to downgrade when something is broken in the latest version (please report an issue in this repository). Use the following syntax to install version `1.0.0`:

```shell
ansible-galaxy collection install manala.path:==1.0.0
```

### Installing the Collection from Github

In case of unavailability of ansible-galaxy, we host a tar.gz of every version of our collection on github:
  - Check latest version available [here](https://github.com/manala/ansible-path/releases)
  - Use your prefered method:
    - cli:
      ```shell
      ansible-galaxy collection install https://github.com/manala/ansible-path/releases/download/$VERSION/manala-path-$VERSION.tar.gz
      ```
    - requirements.yaml:
      ```yaml
      collections:
        - name: https://github.com/manala/ansible-path/releases/download/$VERSION/manala-roles-$VERSION.tar.gz
          type: url
      ```

See [Ansible Using collections](https://docs.ansible.com/ansible/devel/user_guide/collections_using.html) for more details.

## Use this collection

See the [examples playbook](./examples/examples.yaml).

## Release notes

See the [changelog](https://github.com/manala/ansible-path/blob/main/CHANGELOG.md).

## Contributing to this collection

Found a bug ? Please open an [issue](https://github.com/manala/ansible-path/issues)

You can contact us [here](manala-io.slack.com)

Any kind of contribution is very welcome, you can submit pull requests [here](https://github.com/manala/ansible-roles/pulls)

This collection uses [molecule](https://github.com/ansible-community/molecule), [ansible-lint](https://github.com/ansible-community/ansible-lint), and `ansible-test` for linting and testing roles.

All of these tools are available through the excellent [ansible-toolset](https://github.com/ansible-community/toolset) docker image.

Open a docker shell
```shell
make sh
```

Launch sanity tests (first time with `--requirements`)
```shell
ansible-test sanity --python 3.11 --requirements
ansible-test sanity --python 3.11
```

Launch units tests (first time with `--requirements`) over a specific file or not
```shell
ansible-test units --python 3.11 --requirements
ansible-test units --python 3.11
ansible-test units --python 3.11 tests/unit/plugins/lookup/test_foo.py
```

## Licensing

This collection is distributed under the MIT license.

See [LICENSE](https://opensource.org/licenses/MIT) to see the full text.

# Author information

Manala [**(http://www.manala.io/)**](http://www.manala.io)
