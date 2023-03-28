### Install
1. Install hugo with homebrew


### Run server
```
hugo server
```

### To document
- I started using the Coder theme: https://github.com/luizdepra/hugo-coder/
- Override css by using: assets/scss/custom.scss

### Override partial templates
Partial templates—like single page templates and list page templates—have a specific lookup order. However, partials are simpler in that Hugo will only check in two places:

1. layouts/partials/*<PARTIALNAME>.html
2. themes/<THEME>/layouts/partials/*<PARTIALNAME>.html

