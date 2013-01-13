# Varfile

Varfile is a little executable to write and read variables from a text file.
It's job is trivial, but the little automation becomes very handy when dealing
distributed environments. Varfile is suitable to be used as a tool for
configuration of remote servers when used in conjunction with other automation
tools like capistrano.

## Installation

Add this line to your application's Gemfile:

    gem 'varfile'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install varfile

## Usage

```bash
$ varfile set FOO bar --file=/u/app/shared/config/.env
```

```bash
$ varfile get FOO --file=/u/app/shared/config/.env
bar
```

```bash
$ varfile list --file=/u/app/shared/config/.env
FOO=bar
```

```bash
$ varfile rm FOO --file=/u/app/shared/config/.env
```

```bash
$ varfile list --file=/u/app/shared/config/.env
$
```

If `--file` option is missing, variables will be written to a file named
`Varfile`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
