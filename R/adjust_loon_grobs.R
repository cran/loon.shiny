adjust_loon_grobs <- function(loon.grobs, loonWidgetsInfo = NULL) {

  # if the loonGrob is constructed by a "pointsGrob",
  # we turn the "pointsGrob" to a gTree whose child is a pointsGrob only to draw one point
  loon.grobs <- lapply(loon.grobs, function(loon.grob) pointsGrob_to_gTree(loon.grob))

  if(!is.null(loonWidgetsInfo)) {

    loon.grobs <- lapply(seq(length(loon.grobs)),
                         function(i) {

                           loon.grob <- loon.grobs[[i]]
                           widgetInfo <- loonWidgetsInfo[[i]]
                           whichIsSelected <- if(is.null(widgetInfo$selected)) integer(0) else which(widgetInfo$selected)

                           resetOrder_grob(loon.grob, widgetInfo, index = whichIsSelected)
                         }
    )

    stats::setNames(loon.grobs, names(loonWidgetsInfo))

  } else loon.grobs
}

pointsGrob_to_gTree <- function(loon.grob) {
  obj <- character(0)
  class(obj) <- names(loon.grob$children)
  UseMethod("pointsGrob_to_gTree", obj)
}

pointsGrob_to_gTree.default <- function(loon.grob) loon.grob

pointsGrob_to_gTree.l_plot <- function(loon.grob) {

  scatterplotGrob <- grid::getGrob(loon.grob, "scatterplot")
  childrenName <- scatterplotGrob$childrenOrder

  if(childrenName != "points: mixed glyphs" && childrenName != "points: missing glyphs") {
    # extend pointsGrob to gTree
    args <- getGrobArgs(scatterplotGrob$children[[scatterplotGrob$childrenOrder]])
    lenPch <- length(args$pch)
    lenCol <- length(args$gp$col)
    lenFontsize <- length(args$gp$fontsize)
    lenFill <- length(args$gp$fill)

    grid::setGrob(loon.grob,
            gPath = scatterplotGrob$childrenOrder,
            newGrob = gTree(
              children = do.call(
                gList,
                lapply(seq(length(args$x)),
                       function(i) {

                         pch <- ifelse(lenPch == 1, args$pch, args$pch[i])
                         fill <- ifelse(lenFill == 1, args$gp$fill, args$gp$fill[i])
                         col <- ifelse(lenCol == 1, args$gp$col, args$gp$col[i])
                         fontsize <- ifelse(lenFontsize == 1, args$gp$fontsize, args$gp$fontsize[i])

                         pointsGrob(
                           x = args$x[i],
                           y = args$y[i],
                           pch = pch,
                           size = args$size,
                           name = paste0("primitive_glyph ", i),
                           gp = if(pch %in% 21:24) {
                             gpar(
                               fill = fill,
                               col = col,
                               fontsize = fontsize
                             )
                           } else {
                             gpar(
                               col = col,
                               fontsize = fontsize
                             )
                           },
                           vp = args$vp
                         )
                       }
                )
              ),
              name = scatterplotGrob$childrenOrder
            )
    )
  } else loon.grob
}

resetOrder_grob <- function(loon.grob, widgetInfo, index) {
  obj <- character(0)
  class(obj) <- names(loon.grob$children)
  UseMethod("resetOrder_grob", obj)
}

resetOrder_grob.default <- function(loon.grob, widgetInfo, index) loon.grob

resetOrder_grob.l_plot <- function(loon.grob, widgetInfo, index) {


  scatterplotGrob <- grid::getGrob(loon.grob, "scatterplot")
  # only one child
  pointsTreeName <- scatterplotGrob$childrenOrder

  displayOrder <- widgetInfo$displayOrder
  newGrob <- grid::getGrob(loon.grob, pointsTreeName)

  loon.grob <- grid::setGrob(
    gTree = loon.grob,
    gPath = pointsTreeName,
    newGrob = gTree(
      children = gList(
        newGrob$children[displayOrder]
      ),
      name = newGrob$name
    )
  )

  if(length(index) > 0) {

    set_color_grob(
      loon.grob = loon.grob,
      index = index,
      newColor = widgetInfo$color[index],
      pointsTreeName = pointsTreeName
    )
  } else loon.grob
}

resetOrder_grob.l_graph <- function(loon.grob, widgetInfo, index) {

  if(length(index) > 0) {

    set_color_grob(
      loon.grob = loon.grob,
      index = index,
      newColor = widgetInfo$color[index]
    )
  } else loon.grob
}

resetOrder_grob.l_serialaxes <- function(loon.grob, widgetInfo, index) {


  axesLayout <- get_axesLayout(loon.grob)
  axesGpath <- if(axesLayout == "parallel") "parallelAxes" else "radialAxes"

  displayOrder <- widgetInfo$displayOrder
  newGrob <- grid::getGrob(loon.grob, axesGpath)

  loon.grob <- grid::setGrob(
    gTree = loon.grob,
    gPath = axesGpath,
    newGrob = gTree(
      children = gList(
        newGrob$children[displayOrder]
      ),
      name = newGrob$name
    )
  )

  if(length(index) > 0) {

    set_color_grob(
      loon.grob = loon.grob,
      index = index,
      newColor = widgetInfo$color[index],
      axesGpath = axesGpath
    )
  } else loon.grob
}
