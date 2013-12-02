# Design Template
This is a template for allowing web designers to quickly design in the browser. With just a few commands you'll have a living styleguide up and running which is automatically generated and reloads when changes are made to the stylesheet files.

Once completed, the result will be a collection of stylesheets you can pass on to developers, and a styleguide which you can host somewhere and present to clients.

This template includes options for using [Twitter Bootstrap](http://getbootstrap.com), [Zurb Foundation](http://foundation.zurb.com), or [Axis CSS](http://roots.cx/axis/).

## Prerequisites

* [NodeJS](nodejs.org)
* [NPM](npmjs.org)
* [Browser Live Reload Extension](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-)

## Setup

Clone the repo to your computer, `cd` into the directory, then run:
```
npm install
```

This will install the project's dependencies. You must choose if you want to use Bootstrap, Foundation, or Axis by editing the line in the `main.style` file:

```
// @import 'lib/bootstrap/bootstrap'
// @import 'lib/foundation/foundation'
// @import 'lib/axis/index'
```

Styles will be compiled using [Nib](http://visionmedia.github.io/nib/) by default, which gives you lots of useful functions.

## Editing

To create style declarations that appear in the styleguide, you should create comments in the CSS that are in this format:

```
// Title
//
// Description
//
// .classname - description of what applying this class will do
// .classname - description of what applying this class will do
//
// Markup:
// HTML markup that demonstrates how these styles can be applied
//
// Styleguide Position
```

Here is an example:

```
// Buttons
//
// These are the button styles used throughout the website:
//
// .positive - a button for positive actions, like save, continue, etc.
// .negative - a button for negative actions, like delete, back, etc.
//
// Markup:
// <button class="{$modifiers}">My button</button>
//
// Styleguide 1.1
```

You should also edit the ```/src/css/styleguide.md``` file, which will be the index page for the styleguide.

## Running

When you're ready to get started, run:
```
grunt
```

This will open a new browser tab where you can view your styleguide. Every time you make changes, the page will automatically refresh. If you accidentally close the tab, you can close and run Grunt again, or otherwise just go to: [http://localhost:9000/styleguide](http://localhost:9000/styleguide).

### Changelog

* 02/12/2013 - Created