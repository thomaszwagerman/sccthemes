#' Defince scc style for ggplot2
#'
#' @param format can be one of "report", "presentation" or "tweet". Will adjust
#' font sizes approriately for that format.
#'
#' @details Defines a ggplot2 style using SCC font, ensuring consistent
#' font size styling, colours and plot margin
#'
#' @export
scc_style <- function(format = "report") {

  stopifnot(
    format %in% c("report", "presentation", "tweet")
  )

  font <- "Source Sans Pro"
  get_scc_font()

  text_size <- ifelse(format == "report", 12, 24)
  title_size <- ifelse(format == "report", 18, 36)

  ggplot2::theme(
    # Title and subtitle styling
    plot.title = ggplot2::element_text(
      family = font,
      size = title_size,
      face = "bold", color = "#222222"
    ),
    plot.subtitle = ggplot2::element_text(
      family = font,
      size = text_size,
      margin = ggplot2::margin(9, 0, 9, 0)
    ),
    plot.caption = ggplot2::element_blank(),

    # Legend styling
    legend.position = "top",
    legend.text.align = 0,
    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(
      family = font,
      size = text_size,
      color = "#222222"
    ),

    # Axis styling
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(
      family = font,
      size = text_size,
      color = "#222222"
    ),
    axis.text.x = ggplot2::element_text(
      size = text_size,
      margin = ggplot2::margin(
        5,
        b = 20
      )),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),

    # Background grid styling
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),

    # Strip text styling, ie facet text
    strip.background = ggplot2::element_rect(fill = "white"),
    strip.text = ggplot2::element_text(size = text_size, hjust = 0)
  )
}
