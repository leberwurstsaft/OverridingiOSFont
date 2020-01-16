This is a proof of concept that on iOS you can override the `systemFont(ofSize:)` and `preferredFont(forTextStyle:)` with a bit of swizzling.

Would also be possible with some ObjC code that arrogantly overrides the existing methods in a category of UIFont.

The one thing that's still missing is to override fonts set in a Storyboard when it's using text styles instead of System Font (of size x).

