## Moola

Start the development server using

```bash
thin -R config.ru start
```

Sass is used for styling, so start the sass watcher using

```bash
cd public
sass --watch stylesheets/sass:stylesheets -r ./stylesheets/sass/bourbon/lib/bourbon.rb
```

Sass can now be inserted into stylesheets/sass/moola.scss and all
changes will be compiled into stylesheets/moola.css
