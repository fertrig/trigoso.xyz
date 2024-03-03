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
2. Pull latest on git submodules (using themes/hugo-coder as git submodule)
```sh
git submodule update --init --recursive
```


### Run server
```
hugo server
```

### Generate resume html and pdf
```
sh gen_resume.sh
```

### To document
- I started using the Coder theme: https://github.com/luizdepra/hugo-coder/
- Override css by using: assets/scss/custom.scss
- Generate favicon using: https://favicon.io/favicon-generator/

### Brand colors
Greens inpired by the Andean Meadow Greens. Generated by a ChatGPT prompt similar to "List greens in hex code inspired by the Andean Meadow Greens"

Andean Meadow Greens:
- Mountain Pine Green: #1C4E2D
- Highland Moss: #476042
- Inca Trail Fern: #356E3B
- Sacred Valley Jade: #0E5947

Browns that harmonize with the greens above:
- Rich Earth Brown: #5B3A29
- Warm Chestnut Brown: #8C6D5F
- Golden Wheat Brown: #B08E71

See brand-3.png and brand-5.png under static/images for screenshots of the colors.

However, some of those colors aren't high contrast enough to put under light or dark text.
Use an accessibility tool to get higher contrast colors if you are going to put text over them.


### Food
To add content:
- To add a new recipe add a post in content/food/year, you can use a featuredImage from content/food/photos
- To just add a photo, add it to food/photos as a compressed jpeg
- TODO: captions of photos in food/photos is not consistent between local and prod, make them consistent, 
  easiest would be to make it look like prod by changing the files names to dash separated file names.

To understand the food layout:
- In `food/_index.md`, `type: food` maps to directory `layouts/food`.
- In `food/photos/index.md`, `layout: photos` and `type: food` map to `layout/food/photos.html`.
- layouts/food/photos.html dynamically renders the food/photos page
- layouts/food/list.html only renders pages after a certain date which filters out the pages prep and 
  photos which don't have a date
- layouts/food/single.html renders the `featuredImage` if set
- layouts/food/single.html renders a Table of Contents if the page sets `toc: true`