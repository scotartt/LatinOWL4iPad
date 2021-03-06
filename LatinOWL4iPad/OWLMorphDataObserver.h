//
// Created by smcphee on 13/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

@class OWLMorphData;


@protocol OWLMorphDataObserver <NSObject>
@required
    - (void)refreshViewData:(OWLMorphData *)morphData;

    - (void)showError:(NSError *)error forConnection:(NSURLConnection *)connection fromData:(OWLMorphData *)morphData;

    - (void)showError:(NSException *)exception forSearchURL:(NSString *)searchTerm fromData:(OWLMorphData *)morphData;
@end
