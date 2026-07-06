---
name: azal Theme
colors:
  surface: '#12131b'
  surface-dim: '#12131b'
  surface-bright: '#393842'
  surface-container-lowest: '#0d0d16'
  surface-container-low: '#1b1b24'
  surface-container: '#1f1f28'
  surface-container-high: '#292932'
  surface-container-highest: '#34343d'
  on-surface: '#e4e1ee'
  on-surface-variant: '#c4c6d1'
  inverse-surface: '#e4e1ee'
  inverse-on-surface: '#302f39'
  outline: '#8e909b'
  outline-variant: '#43474f'
  surface-tint: '#acc7ff'
  primary: '#acc7ff'
  on-primary: '#062f64'
  primary-container: '#7e9cd8'
  on-primary-container: '#0c3268'
  inverse-primary: '#3f5e96'
  secondary: '#aed280'
  on-secondary: '#1f3700'
  secondary-container: '#324f0b'
  on-secondary-container: '#9dc071'
  tertiary: '#ffb3b0'
  on-tertiary: '#68000f'
  tertiary-container: '#ff6c6c'
  on-tertiary-container: '#6e0011'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d7e2ff'
  primary-fixed-dim: '#acc7ff'
  on-primary-fixed: '#001a40'
  on-primary-fixed-variant: '#25467c'
  secondary-fixed: '#c9ef9a'
  secondary-fixed-dim: '#aed280'
  on-secondary-fixed: '#102000'
  on-secondary-fixed-variant: '#324f0b'
  tertiary-fixed: '#ffdad8'
  tertiary-fixed-dim: '#ffb3b0'
  on-tertiary-fixed: '#410006'
  on-tertiary-fixed-variant: '#8c1620'
  background: '#12131b'
  on-background: '#e4e1ee'
  surface-variant: '#34343d'
typography:
  display-lg:
    fontFamily: Rubik
    fontSize: 48px
    fontWeight: '500'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Rubik
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 40px
  headline-md:
    fontFamily: Rubik
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 32px
  body-lg:
    fontFamily: Rubik
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Rubik
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Rubik
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  code-md:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 40px
  xl: 64px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 48px
---

## Design Spec

This is just a quick rundown of the design choices for the theme. I wanted something that feels like an old ink-wash painting—calm, uncluttered, and easy on the eyes. No harsh grids or bright neon colors here. 

## Colors

I'm keeping it simple and sticking to a matte, dark palette:

- **Sumi-Black (#1F1F28)**: The main background. Think dry ink on paper. 
- **Indigo (#7E9CD8)**: Primary accent. Used for highlighted items and active states. 
- **Sage (#98BB6C)**: Secondary accent. Mostly for success states.
- **Vermillion (#C34043)**: Just for errors or anything that really needs attention.
- **Aged-Paper (#DCD7BA)**: Text and icons. Pure white hurts to look at in the dark, so this off-white is much better.

## Typography

- **Rubik**: Used everywhere for normal text. The slightly rounded edges fit the whole "ink" vibe well.
- **JetBrains Mono**: For the terminal and any code/technical output.

## Layout & Spacing

Keep it breezy. We use an 8px grid system. Don't crowd things—give the text and menus room to breathe. 

## Elevation & Shadows

Instead of sharp drop shadows, I'm using "ink-bleed" style shadows. Basically, just a really wide blur (20px+) with super low opacity (around 5%) so things look like they are softly glowing or bleeding into the paper rather than floating above it.

## Shapes & UI

- **No sharp edges**: No 90-degree corners. 
- **Corners**: Large boxes get a 16px radius. Buttons and inputs should be pill-shaped.
- **Borders**: Keep them thin (1px) and subtle if you really need them.

If you're building on top of this, just try to keep everything looking soft and deliberate.