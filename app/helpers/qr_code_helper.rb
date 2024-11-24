module QrCodeHelper
  def qr_code_svg(url)
    svg = RQRCode::QRCode.new(url).as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 10,
      standalone: true,
      use_path: true,
      viewbox: true,
      svg_attributes: { width: "200", height: "200" }
    )

    ActiveSupport::SafeBuffer.new(svg)
  end
end
