//
// Created by smcphee on 1/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "OWLHistoryTableCell.h"


@implementation OWLHistoryTableCell

    @synthesize historyItem;


    - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            // Initialization code
            NSLog(@"init %@", self);
        }
        return self;
    }


    - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        NSLog(@"selected %@", self);

        [super setSelected:selected animated:animated];
    }
@end
