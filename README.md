# personal page

Created with zola (rust). Similar to hugo (go).

## Howto
1. edit markdown files in `content/` folder
2. test with local serving: `zola serve`
3. publish with: `zola build`. This generates static files in folder `docs/`

```bash
# start local serving
./zola serve
# server is available at http://127.0.0.1:1111

# build docs/ folder
./zola build --output-dir docs --force
```

## Get zola
Download zola from https://github.com/getzola/zola/releases (i.e. for Linux `*.tar.gz`). Extract with `tar xfv *.tar.gz`.

```bash
./zola
```