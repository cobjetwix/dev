function weAreInAnIFrame() {
	return window.parent !== window;
}

module.exports = weAreInAnIFrame;
