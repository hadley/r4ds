---
title: "Viridis Demo"
output: html_document
---

```{r include = FALSE}
library(viridis)
```

The code below demonstrates two color palettes in the [viridis](https://github.com/sjmgarnier/viridis) package. Each plot displays a contour map of the Maunga Whau volcano in Auckland, New Zealand.

## Viridis colors

```{r}
image(volcano, col = viridis(200))
```

## Magma colors

```{r}
image(volcano, col = viridis(200, option = "A"))
```
