- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *url = [request URL];
	
	// Intercept the external http requests and forward to Safari.app
	// Otherwise forward to the PhoneGap WebView
        // Avoid opening iFrame URLs in Safari by inspecting the `navigationType`
	if (navigationType == UIWebViewNavigationTypeLinkClicked && [[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"]) {
		[[UIApplication sharedApplication] openURL:url];
		return NO;
	}
	else {
		return [ super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType ];
	}
}