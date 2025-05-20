import Cocoa

// Subclass to allow borderless window to become key
class OverlayWindow: NSWindow {
    override var canBecomeKey: Bool { return true }
    override var canBecomeMain: Bool { return true }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {
    var window: OverlayWindow!
    var textField: NSTextField!
    var eventMonitor: Any?
    var previousApp: NSRunningApplication?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        previousApp = NSWorkspace.shared.frontmostApplication

        guard let screenFrame = NSScreen.main?.frame else { return }
        let width = screenFrame.width * 0.6
        let height: CGFloat = 30
        let x = (screenFrame.width - width) / 2
        let y = (screenFrame.height - height) / 2
        let frame = NSRect(x: x, y: y, width: width, height: height)

        // Create and style overlay window
        window = OverlayWindow(
            contentRect: frame,
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )
        window.level = .floating
        window.isOpaque = false
        window.backgroundColor = NSColor(white: 0.9, alpha: 0.6)
        window.hasShadow = true
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        // Round corners using layer
        window.contentView?.wantsLayer = true
        window.contentView?.layer?.cornerRadius = 8
        window.contentView?.layer?.masksToBounds = true

        // Create transparent text field
        textField = NSTextField(frame: NSRect(x: 10, y: 4, width: width - 20, height: height - 8))
        textField.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        textField.placeholderString = "Enter command…"
        textField.isBordered = false
        textField.focusRingType = .none
        textField.backgroundColor = .clear
        textField.drawsBackground = false
        textField.delegate = self
        window.contentView?.addSubview(textField)

        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        window.makeFirstResponder(textField)

        // Monitor Esc key
        eventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 53 {
                NSApp.terminate(nil)
                return nil
            }
            return event
        }
    }

    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            let input = textField.stringValue
            print(input)
            fflush(stdout)
            textField.stringValue = ""
            return true
        }
        return false
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
        }
        previousApp?.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
    }
}

// Start application
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()

// Compile and run:
// swiftc -o ucli -framework Cocoa main.swift
// ./ucli

