// Draws the app icon: the LANCER, nose up, the way the Garage shows it.
// The hull is the same four points as shipPath() in the game:
//   (r,0)  (-.72r,.68r)  (-.35r,0)  (-.72r,-.68r)
// Usage: icon <output.iconset dir>
import Cocoa

let out = CommandLine.arguments[1]
try? FileManager.default.createDirectory(atPath: out, withIntermediateDirectories: true)

func rgb(_ hex: UInt32, _ a: CGFloat = 1) -> CGColor {
    CGColor(srgbRed: CGFloat((hex >> 16) & 255) / 255,
            green: CGFloat((hex >> 8) & 255) / 255,
            blue: CGFloat(hex & 255) / 255, alpha: a)
}

func draw(_ px: Int) -> Data {
    let s = CGFloat(px)
    let ctx = CGContext(data: nil, width: px, height: px, bitsPerComponent: 8, bytesPerRow: 0,
                        space: CGColorSpace(name: CGColorSpace.sRGB)!,
                        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    ctx.scaleBy(x: s / 1024, y: s / 1024)          // draw everything on a 1024 grid

    // the tile: Apple's grid puts an 824 square inside the 1024 canvas
    let tile = CGRect(x: 100, y: 100, width: 824, height: 824)
    let shape = CGPath(roundedRect: tile, cornerWidth: 185, cornerHeight: 185, transform: nil)

    // drop shadow under the tile
    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -10), blur: 28, color: rgb(0x000000, 0.45))
    ctx.addPath(shape); ctx.setFillColor(rgb(0x0b1121)); ctx.fillPath()
    ctx.restoreGState()

    ctx.saveGState()
    ctx.addPath(shape); ctx.clip()

    // the panel gradient from the game's screens
    let bg = CGGradient(colorsSpace: nil, colors: [rgb(0x182340), rgb(0x0b1121), rgb(0x05060d)] as CFArray,
                        locations: [0, 0.6, 1])!
    ctx.drawLinearGradient(bg, start: CGPoint(x: 200, y: 924), end: CGPoint(x: 824, y: 100), options: [])

    // the map's faint grid
    ctx.setStrokeColor(rgb(0x4d9dff, 0.07)); ctx.setLineWidth(2)
    for i in stride(from: 100, through: 924, by: 69) {
        ctx.move(to: CGPoint(x: CGFloat(i), y: 100)); ctx.addLine(to: CGPoint(x: CGFloat(i), y: 924))
        ctx.move(to: CGPoint(x: 100, y: CGFloat(i))); ctx.addLine(to: CGPoint(x: 924, y: CGFloat(i)))
    }
    ctx.strokePath()

    // a few stars, fixed so every size matches
    let stars: [(CGFloat, CGFloat, CGFloat, CGFloat)] = [
        (210, 790, 7, 0.8), (300, 300, 5, 0.5), (760, 820, 6, 0.6), (820, 360, 8, 0.7),
        (690, 210, 5, 0.45), (180, 520, 4, 0.4), (860, 600, 4, 0.45), (400, 860, 4, 0.5),
        (250, 180, 6, 0.55), (560, 880, 3, 0.35)]
    for (x, y, r, a) in stars {
        ctx.setFillColor(rgb(0xa0b9f0, a)); ctx.fill(CGRect(x: x, y: y, width: r, height: r))
    }

    // a soft blue bloom behind the ship
    let bloom = CGGradient(colorsSpace: nil, colors: [rgb(0x4d9dff, 0.30), rgb(0x4d9dff, 0)] as CFArray,
                           locations: [0, 1])!
    ctx.drawRadialGradient(bloom, startCenter: CGPoint(x: 512, y: 500), startRadius: 0,
                           endCenter: CGPoint(x: 512, y: 500), endRadius: 400, options: [])

    // the LANCER. Nose up: game (x, y) becomes (-y, x). Shifted down by its
    // own centre so the arrow sits in the middle of the tile.
    let r: CGFloat = 330, cx: CGFloat = 512, cy: CGFloat = 512 - 0.14 * r
    let hull: [(CGFloat, CGFloat)] = [(1, 0), (-0.72, 0.68), (-0.35, 0), (-0.72, -0.68)]
    let ship = CGMutablePath()
    for (i, p) in hull.enumerated() {
        let pt = CGPoint(x: cx - p.1 * r, y: cy + p.0 * r)
        if i == 0 { ship.move(to: pt) } else { ship.addLine(to: pt) }
    }
    ship.closeSubpath()

    // thruster flare out of the notch at the back
    let flare = CGGradient(colorsSpace: nil, colors: [rgb(0x9fd0ff, 0.85), rgb(0x4d9dff, 0)] as CFArray,
                           locations: [0, 1])!
    let tail = CGPoint(x: cx, y: cy - 0.35 * r)
    ctx.drawRadialGradient(flare, startCenter: tail, startRadius: 0,
                           endCenter: CGPoint(x: cx, y: tail.y - 40), endRadius: 120, options: [])

    // hull, glow and outline, in the game's colours
    ctx.saveGState()
    ctx.setShadow(offset: .zero, blur: 60, color: rgb(0x9fd0ff, 0.9))
    ctx.addPath(ship); ctx.setFillColor(rgb(0x0a1426)); ctx.fillPath()
    ctx.restoreGState()
    ctx.saveGState()
    ctx.setShadow(offset: .zero, blur: 30, color: rgb(0x9fd0ff))
    ctx.addPath(ship); ctx.setStrokeColor(rgb(0xdfe9ff)); ctx.setLineWidth(22)
    ctx.setLineJoin(.miter); ctx.setMiterLimit(10); ctx.strokePath()
    ctx.restoreGState()

    ctx.restoreGState()

    // hairline frame, like the game's panels
    ctx.addPath(CGPath(roundedRect: tile.insetBy(dx: 3, dy: 3), cornerWidth: 182, cornerHeight: 182, transform: nil))
    ctx.setStrokeColor(rgb(0x4d9dff, 0.45)); ctx.setLineWidth(5); ctx.strokePath()

    let rep = NSBitmapImageRep(cgImage: ctx.makeImage()!)
    return rep.representation(using: .png, properties: [:])!
}

for (name, px) in [("16x16", 16), ("16x16@2x", 32), ("32x32", 32), ("32x32@2x", 64),
                   ("128x128", 128), ("128x128@2x", 256), ("256x256", 256), ("256x256@2x", 512),
                   ("512x512", 512), ("512x512@2x", 1024)] {
    try! draw(px).write(to: URL(fileURLWithPath: "\(out)/icon_\(name).png"))
}
