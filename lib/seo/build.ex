defprotocol SEO.Build do
  @moduledoc """
  Protocol to implement functions for customizing your items. It's recommended
  to also use `SEO.Builder` so that skeleton functions can be implemented for
  you, and you'd only implement the ones you need.
  """
  @fallback_to_any true

  @spec breadcrumb_list(term, term) :: SEO.Breadcrumb.List.t() | nil
  def breadcrumb_list(term, default)
  def breadcrumb_list(term)

  @spec open_graph(term, term) :: SEO.OpenGraph.t() | nil
  def open_graph(term, default)
  def open_graph(term)

  @spec twitter(term, term) :: SEO.Twitter.t() | nil
  def twitter(term, default)
  def twitter(term)

  @spec site(term, term) :: SEO.Site.t() | nil
  def site(term, default)
  def site(term)

  @spec unfurl(term, term) :: SEO.Unfurl.t() | nil
  def unfurl(term, default)
  def unfurl(term)
end

defimpl SEO.Build, for: Any do
  use SEO.Builder
end
