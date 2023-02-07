// ==UserScript==
// @name         Anti-Anti-Devtools
// @grant        unsafeWindow
// @run-at       document-start
// ==/UserScript==

(function() {
    'use strict';

    let knownRoots = new WeakSet();
    function wrapRegExp(root) {
        if (knownRoots.has(root))
            return;
        let _proto = void 0;
        try {
            _proto = root.RegExp.prototype;
        } catch(ignore) {
            return;
        }
        // Prevent RegExpt + toString trick (technically possible with any other object, but I encountered only this one
        let _RE_tS = Object.getOwnPropertyDescriptor(_proto, 'toString');
        let _RE_tSV = _RE_tS.value || _RE_tS.get();
        let fts = Function.prototype.toString;
        Object.defineProperty(_proto, 'toString', {
            enumerable: _RE_tS.enumerable,
            configurable: _RE_tS.configurable,
            get: () => _RE_tSV,
            set: function(val) {
                console.warn('Attempt to change toString for', this, 'with', fts.call(val));
                //throw 'stop it!';
                return true;
            }
        });
    }

    wrapRegExp(unsafeWindow);

    let _contentWindow = Object.getOwnPropertyDescriptor(HTMLIFrameElement.prototype, 'contentWindow');
    let _get_contentWindow = _contentWindow.get;
    _contentWindow.get = function() {
        let _cw = _get_contentWindow.apply(this, arguments);
        if (_cw)
            wrapRegExp(_cw);
        return _cw;
    };
    Object.defineProperty(HTMLIFrameElement.prototype, 'contentWindow', _contentWindow);
})();


// The above isn't sufficient for sites like samy.pl, which simply accesses console. console must be deep copied to _console (so I can still use it) and the original must be yeeted (he checks for null, so I set it to false)

_console = console;
console = false;

// devtoolsdetector
const devtoolsDetector.launch = () => void
const devtoolsDetector = () => void

// Override the addEventListener function to block preventDefault()
(function() {
    var _addEventListener = EventTarget.prototype.addEventListener;
    EventTarget.prototype.addEventListener = function(event, listener, useCapture) {
        var newListener = function(event) {
            // Block the preventDefault() method
            event.preventDefault = function() {};
            listener(event);
        };
        _addEventListener.call(this, event, newListener, useCapture);
    };
})();