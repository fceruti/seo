defmodule SEO.OpenGraph.Image do
  @moduledoc """
  URL for the image. The `og:image` property has some optional structured properties:

  - `og:image:url` - Identical to `og:image`.
  - `og:image:secure_url` - An alternate url to use if the webpage requires HTTPS.
  - `og:image:type` - A MIME type for this image.
  - `og:image:width` - The number of pixels wide.
  - `og:image:height` - The number of pixels high.
  - `og:image:alt` - A description of what is in the image (not a caption). If the page specifies an `og:image` it should
  specify `og:image:alt`.

  **NOTE**: to update an image after it's been published, use a new URL for the new image. Images are typically cached
  based on the URL and won't be updated unless the URL changes. In Phoenix, the URL is typically using a hashed
  version of the image (see `mix phx.digest`), so this should be handled automatically.

  Best practices:
  - Use images that are at least 1080 pixels in width for best display on high resolution devices. At the minimum, you should use images that are 600 pixels in width to display image link ads. We recommend using 1:1 images in your ad creatives for better performance with image link ads.
  - Pre-cache your images by running the URL through the URL Sharing Debugger tool to pre-fetch metadata for the website. You should also do this if you update the image for a piece of content.
  - Use `og:image:width` and `og:image:height` Open Graph tags to specify the image dimensions to the crawler so that it can render the image immediately without having to asynchronously download and process it.

  Resources
  - https://ogp.me/#structured
  - https://developers.facebook.com/docs/sharing/best-practices#images
  """

  use Phoenix.Component

  defstruct [
    :url,
    :secure_url,
    :type,
    :width,
    :height,
    :alt
  ]

  @type t :: %__MODULE__{
          url: URI.t() | String.t(),
          secure_url: URI.t() | String.t(),
          type: mime(),
          width: pixels(),
          height: pixels(),
          alt: String.t()
        }

  @type mime :: String.t()
  @type pixels :: pos_integer()

  def build(attrs) when is_map(attrs) or is_list(attrs) do
    struct(%__MODULE__{}, attrs)
  end

  attr(:content, :any, required: true, doc: "Either an `SEO.OpenGraph.Image`, a string, or a URI")

  def meta(assigns) do
    case assigns[:content] do
      %__MODULE__{} ->
        ~H"""
        <%= if @content.url do %>
        <SEO.Utils.url property="og:image" content={@content.url} />
        <SEO.Utils.url :if={@content.secure_url} property="og:image:secure_url" content={@content.secure_url} />
        <meta :if={@content.type} property="og:image:type" content={@content.type} />
        <meta :if={@content.width} property="og:image:width" content={@content.width} />
        <meta :if={@content.height} property="og:image:height" content={@content.height} />
        <meta :if={@content.alt} property="og:image:alt" content={@content.alt} />
        <% end %>
        """

      _url ->
        ~H"""
        <SEO.Utils.url property="og:image" content={@content} />
        """
    end
  end
end
