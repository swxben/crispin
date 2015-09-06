# XRPT documentation


## report

`report` is the XRPT doctype.


## title

Text: the title of the report


## content

Contains the content of the report - a set of `pageSequence` elements.


## pageSequence

A set of pages, containing `htmlBlock` and `contentBlock` elements. The page breaks when a `pageSequence` completes.

Elements:

- `orientation`: `portrait`, `landscape`


## htmlBlock, contentBlock

Contains the content of the report. Can contain `set-alignment` and `set-block-styles` attributes.


## table

Table MUST have column widths specified by `col` elements. Tables cannot directly contain rows - tables should contain only `col` elements and one or more of `thead`, `tbody` and `tfoot` elements which in turn contain the `tr` elements. Rows contained in `thead` and `tfoot` show on every page that the table spans - they are page-level headers and footers.


## table cells (td)

Table cells are block level elements that have can contain any of the `set-block-styles` elements. Note that nested tables [do not respect the containing alignment](https://github.com/swxben/swxben.reporting/issues/12).


## set-block-styles

- `colspan`
- `rowspan`
- `background-color`
- `color`
- `height`
- `border`: `true`, `false`
- `border-top`: `true`, `false`
- `border-left`: `true`, `false`
- `border-bottom`: `true`, `false`
- `border-right`: `true`, `false`
- `border-top-style`
- `border-top-width`
- `border-top-color`
- `border-left-style`
- `border-left-width`
- `border-left-color`
- `border-bottom-style`
- `border-bottom-width`
- `border-bottom-color`
- `border-right-style`
- `border-right-width`
- `border-right-color`
- `border-style`
- `border-width`
- `border-color`
- `padding-top`
- `padding-left`
- `padding-bottom`
- `padding-right`
- `padding`
- `font-family`
- `font-size`
- `font-weight`
- `font-style`
- `text-decoration`


## set-alignment

- `align`: `left`, `center`, `right`, `justify`


## blockquote


## h1, h2, h3, h4, h5, h6

May contain header style attributes:

- `space-before`
- `space-after`
- `font-size`
- `set-alignment` attributes

## a

Anchors are basic HTML anchors, with only the `href` attribute used:

	Link to a <a href="http://...">website</a>.





