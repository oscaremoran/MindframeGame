// Mindframe as a Mac app: one window with the game's index.html inside it.
// The page is bundled in Contents/Resources, so the app needs nothing else.
//
// What the app adds over a browser:
//   - the game pauses when you switch away or minimise
//   - sound is allowed from launch, so the menu theme starts straight away
import Cocoa
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var web: WKWebView!

    func applicationDidFinishLaunching(_ note: Notification) {
        let cfg = WKWebViewConfiguration()
        cfg.websiteDataStore = .default()                   // saves (localStorage) persist between launches
        cfg.mediaTypesRequiringUserActionForPlayback = []   // sound before the first click

        // tells the game it is in the app: it starts its sound and hides the download link
        cfg.userContentController.addUserScript(WKUserScript(
            source: "window.MF_APP = true;", injectionTime: .atDocumentStart, forMainFrameOnly: true))

        // the game is drawn at 1000 x 680, so the window keeps that shape
        let rect = NSRect(x: 0, y: 0, width: 1200, height: 816)
        web = WKWebView(frame: rect, configuration: cfg)
        if #available(macOS 12.0, *) { web.underPageBackgroundColor = .black }

        window = NSWindow(contentRect: rect,
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered, defer: false)
        window.title = "Mindframe"
        window.backgroundColor = .black
        window.contentAspectRatio = NSSize(width: 1000, height: 680)
        window.collectionBehavior = .fullScreenPrimary
        window.contentView = web
        window.center()
        window.setFrameAutosaveName("MindframeWindow")

        // a missing game file gets a message, not a crash
        guard let page = Bundle.main.url(forResource: "index", withExtension: "html") else {
            let alert = NSAlert()
            alert.messageText = "Mindframe could not find its game file."
            alert.informativeText = "This copy of the app is incomplete. Rebuild it with build.sh, or download it again."
            alert.runModal()
            NSApp.terminate(nil)
            return
        }
        web.loadFileURL(page, allowingReadAccessTo: page.deletingLastPathComponent())

        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(web)
        NSApp.activate(ignoringOtherApps: true)

        // switching to another app, or minimising, pauses a level
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(pauseGame), name: NSApplication.didResignActiveNotification, object: nil)
        nc.addObserver(self, selector: #selector(pauseGame), name: NSWindow.didMiniaturizeNotification, object: window)
    }

    @objc func pauseGame() {
        web.evaluateJavaScript("window.mfAppBlur && window.mfAppBlur()", completionHandler: nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool { true }
}

// a menu bar, so Cmd+Q quits and Ctrl+Cmd+F goes full screen
func buildMenu() -> NSMenu {
    let bar = NSMenu()

    let appItem = NSMenuItem(); bar.addItem(appItem)
    let appMenu = NSMenu()
    appMenu.addItem(withTitle: "Hide Mindframe", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h")
    appMenu.addItem(.separator())
    appMenu.addItem(withTitle: "Quit Mindframe", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
    appItem.submenu = appMenu

    let viewItem = NSMenuItem(); bar.addItem(viewItem)
    let viewMenu = NSMenu(title: "View")
    let fs = viewMenu.addItem(withTitle: "Enter Full Screen", action: #selector(NSWindow.toggleFullScreen(_:)), keyEquivalent: "f")
    fs.keyEquivalentModifierMask = [.control, .command]
    viewItem.submenu = viewMenu

    let winItem = NSMenuItem(); bar.addItem(winItem)
    let winMenu = NSMenu(title: "Window")
    winMenu.addItem(withTitle: "Minimize", action: #selector(NSWindow.performMiniaturize(_:)), keyEquivalent: "m")
    winMenu.addItem(withTitle: "Close", action: #selector(NSWindow.performClose(_:)), keyEquivalent: "w")
    winItem.submenu = winMenu

    return bar
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.mainMenu = buildMenu()
app.run()
