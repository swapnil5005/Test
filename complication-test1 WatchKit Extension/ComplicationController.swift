//
//  ComplicationController.swift
//  complication-test1 WatchKit Extension
//
//  Created by swapnil pakhare on 26/06/19.
//  Copyright © 2019 swapnil pakhare. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    static let minutesPerTimeline = 1
    
    // MARK: - Timeline Configuration
    
    override init() {
        ExtensionDelegate.scheduleComplicationUpdate()
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date() + TimeInterval(ComplicationController.minutesPerTimeline * 60))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let stringDate: String = dateFormatter.string(from: date as Date)
        print("CUR -> ", stringDate)
        
        if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "ETA")
            template.line2TextProvider = CLKSimpleTextProvider(text: stringDate)
            
            let entry = CLKComplicationTimelineEntry(date: Date() + TimeInterval(60), complicationTemplate: template)
            
            handler(entry)
            
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "SWIGGY")
            template.line2TextProvider = CLKSimpleTextProvider(text: "COOL")
            
            handler(template)
            
        } else {
            handler(nil)
        }
    }
    
}
