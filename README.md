### Add new post
```
hugo new posts/2023/some-new-post.md
```

### Deploy
Just push to main branch. It is hosted by render.com. Sometimes it 
doesn't work so use deploy hook.

```
sh deploy.sh
```

### Override templates
#### Override partial templates
Partial templates—like single page templates and list page templates—have a specific lookup order. However, partials are simpler in that Hugo will only check in two places:

1. layouts/partials/*<PARTIALNAME>.html
2. themes/<THEME>/layouts/partials/*<PARTIALNAME>.html

#### Override sections
A section is something like `posts` in `themes/hugo-coder/layouts/posts`. 
For example, to override the list.html of the posts section, you can add the overriding html in:

1. layout/posts/list.html

### Install
1. Install hugo with homebrew


### Run server
```
hugo server
```

### To document
- I started using the Coder theme: https://github.com/luizdepra/hugo-coder/
- Override css by using: assets/scss/custom.scss

### Next
I was working on the /food area.
- git diff the previous two commits to see what I did then figure out next steps
- I think I had the food page loading posts and rendering its images
- tabs I had open:
  - https://www.budgetbytes.com/peanut-butter-banana-smoothie/
  - https://github.com/lgaida/mediumish-gohugo-theme
  - https://gohugo.io/content-management/shortcodes/#readout
  - https://discourse.gohugo.io/t/variables-in-markdown/7113
  - https://gohugo.io/variables/page/
  - https://gohugo.io/content-management/page-resources/
  - https://gohugo.io/content-management/front-matter/
