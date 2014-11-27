- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
//add below code....
if([[NSString stringWithFormat:@"%@",request.URL] rangeOfString:@"file"].location== NSNotFound)
{
[[UIApplication sharedApplication] openURL:[request URL]];
return NO;
}
BOOL shouldLoad = YES;
// End code