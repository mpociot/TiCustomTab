TiCustomTab
===========================================

This module gives the ability to define some custom Tab / TabGroup settings on iOS.

Features
========
* Custom selected / unselected images for TiTabs
* Custom tint color for TiTabGroup
* Custom TiTabGroup background image


Usage
====================
**Custom background image**

	var tabGroup = Titanium.UI.createTabGroup({
		customBackgroundImage: 'tabbar.png'
	});

**Custom tint color**

	var tabGroup = Titanium.UI.createTabGroup({
		tintColor: 'red'
	});


**Custom selected/unselected images:**

	var tab = Titanium.UI.createTab({  
	    title:'Tab 1',
    	window:win1,
	    images: {
    		selected: 'selected.png',
    		unselected: 'unselected.png'
	   }
	});
**OR**

	var tab = Titanium.UI.createTab();
	tab.setImages({
		selected: 'selected.png',
		unselected: 'unselected.png'
	});

ABOUT THE AUTHOR
========================
I'm a web enthusiast located in germany.

Follow me on twitter: @marcelpociot