#' Get the current selection available in
#' a graph object
#' @description Get the current
#' selection of node IDs or edge IDs
#' from a graph object of class
#' \code{dgr_graph}.
#' @param graph a graph object of class
#' \code{dgr_graph}.
#' @return a vector with the current
#' selection of nodes or edges.
#' @examples
#' # Create a simple graph
#' graph <-
#'   create_graph() %>%
#'   add_path(n = 6)
#'
#' # Select node `4`, then select
#' # all nodes a distance of 1 away
#' # from node `4`, and finally
#' # return the selection of nodes as
#' # a vector object
#' graph %>%
#'   select_nodes(nodes = 4) %>%
#'   select_nodes_in_neighborhood(
#'     node = 4,
#'     distance = 1) %>%
#'   get_selection()
#'
#' # Select edges associated with
#' # node `4` and return the
#' # selection of edges
#' graph %>%
#'   select_edges_by_node_id(
#'     nodes = 4) %>%
#'   get_selection()
#' @export get_selection

get_selection <- function(graph) {

  # Get the name of the function
  fcn_name <- get_calling_fcn()

  # Validation: Graph object is valid
  if (graph_object_valid(graph) == FALSE) {

    emit_error(
      fcn_name = fcn_name,
      reasons = "The graph object is not valid")
  }

  # Obtain the input graph's node and edge
  # selection properties
  n_e_select_properties_in <-
    node_edge_selection_properties(graph = graph)

  # If there is no selection available, return NA
  if (is.na(n_e_select_properties_in[["selection_type"]])) {

    emit_message(
      fcn_name = fcn_name,
      message_body = "there is no active selection of nodes or edges")

    return(NA)
  }

  # For a selection of nodes, return a vector of node
  # ID values
  if (n_e_select_properties_in[["selection_type"]] == "node") {

    # Issue a message to the user
    emit_message(
      fcn_name = fcn_name,
      message_body = glue::glue(
        "there is an active selection of \\
        {n_e_select_properties_in[['selection_count_str']]}"))

    return(as.integer(sort(graph$node_selection$node)))
  }

  # For a selection of edges, return a vector of edge
  # ID values
  if (n_e_select_properties_in[["selection_type"]] == "edge") {

    emit_message(
      fcn_name = fcn_name,
      message_body = glue::glue(
        "there is an active selection of\\
        {n_e_select_properties_in[['selection_count_str']]}"))

    return(as.integer(sort(graph$edge_selection$edge)))
  }
}
