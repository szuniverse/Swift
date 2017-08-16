//
//  ProfileViewModel.swift
//  SamsaraMVVM
//
//  Created by David Szurma on 8/2/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    let profile: Profile
    
    // MARK - Initialization
    
    init(withProfile profile: Profile) {
        self.profile = profile
    }
    
    func timeForProfile() -> String {
        return stringFromTimeInterval(profile.duration)
    }

    func segmentOfTypeEnabled(_ type: SegmentType) -> Bool {
        guard let segment = profile.segmentOfType(type) else { return false }
        return segment.enabled
    }
    
    func numberOfRowsForSegmentOfType(_ type: SegmentType) -> Int {
        var result = 1
        
        guard let segment = profile.segmentOfType(type) else { return result }
        
        switch type {
        case .WarmUp:
            result = segment.enabled ? 2 : 1
        case .CoolDown:
            if segment.enabled {
                result = segment.soundOfTypeEnabled(.Begin) ? 4 : 3
            }
        default:
            result = 1
        }
        
        return result
    }
    
    func setSegmentOfType(type: SegmentType, enabled: Bool) {
        if let segment = profile.segmentOfType(type) {
            // Configure Segment
            segment.enabled = enabled
            
        } else {
            // Create Segment
            let segment = Segment(type: type)
            
            // Configure Segment
            segment.enabled = enabled
            
            // Add Segment to Profile
            profile.segments.append(segment)
        }
    }
    
    func timeForSegmentOfType(type: SegmentType) -> String {
        guard let segment = profile.segmentOfType(type) else { return "00:00" }
        return stringFromTimeInterval(segment.duration)
    }
    
    private func stringFromTimeInterval(_ timeInterval: Double) -> String {
        let timeInterval = Int(timeInterval)
        
        let hours = (timeInterval / 3600)
        let seconds = (timeInterval % 60)
        let minutes = ((timeInterval / 60) % 60)
        
        if hours  > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }

}
