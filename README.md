# personal page

* created with zola (rust). similar to hugo (go).
* build / create docs folder
```
./zola build --output-dir docs
```
* create project or clone a theme 
```
./zola init zola-project
git clone https://github.com/lopes/zola.386
```
* build from a template (in this case zola.386)
```
./zola --root zola.386 build --output-dir docs
```
* local serve
```
./zola serve
```

## Links
* https://www.getzola.org/documentation/getting-started/overview/
