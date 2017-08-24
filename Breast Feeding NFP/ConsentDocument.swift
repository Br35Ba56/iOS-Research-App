/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import ResearchKit

class ConsentDocument: ORKConsentDocument {
  // MARK: Properties
  
  let ipsum = [
    //Overview
    "You are invited to participate in a research study evaluating natural family planning and breastfeeding.",
    //dataGathering
    "The data you are providing will gathered daily when you complete daily tasks.",
    //Privacy
    "Your privacy is protected.  The data that you generate will be securely uploaded to our Amazon Web Service cloud server.  It will remain on the server until the researcher retrieves your data.  Your data is not shared with any outside source.",
    //Data Use
    "The data you provide will help us better understand the physiological characteristics of breastfeeding intensity on postpartum ovarian function.",
    //Time Commitment
    "This study will require a few minutes out of each day.  Every morning you will be asked to provide a urine sample to test using the Clearblue Fertility Monitor.  Throughout the day, we ask that you track each of your breastfeeding sessions so we know how often and how long you are breastfeeding.",
    //Study Tasks
    "We ask that you provide daily first morning urine samples and test them using the Clearblue Fertility Monitor.  If the Clearblue Fertility Monitor identifies a peek (LH present), you will be asked to use progesterone sticks the second day after the first peek.  You will use up to five progesterone sticks with each CBFM peak to confirm ovulation.  Throughout the day, we ask that you track your breastfeeding sessions using the built-in tracker in this application.  You can either use the automatic tracker, where you can start and stop a time before and after a breastfeeding session, or you can manually enter the information by using the manual entry feature by providing the duration of the feed and the time of the feed.",
    //Withdrawing
    "You do not have to be in this study if you do not want to.  If you agree to be in the study, but later change your mind, you may drop out at any time.  There are no penalties or consequences of any kind if you decide that you do not want to participate.  You can stop using this application anytime, however, we would appreciate you emailing us to help us to understand the reasons for discontinuation."
  ]
  
  // MARK: Initialization
  
  override init() {
    super.init()
    
    title = NSLocalizedString("Research Health Study Consent Form", comment: "")
    
    let sectionTypes: [ORKConsentSectionType] = [
      .overview,
      .dataGathering,
      .privacy,
      .dataUse,
      .timeCommitment,
      .studyTasks,
      .withdrawing
    ]
    
    sections = zip(sectionTypes, ipsum).map { sectionType, ipsum in
      let section = ORKConsentSection(type: sectionType)
      
      let localizedIpsum = NSLocalizedString(ipsum, comment: "")
      let localizedSummary = localizedIpsum.components(separatedBy: ".")[0] + "."
      
      section.summary = localizedSummary
      section.content = localizedIpsum
      
      return section
    }
    
    let signature = ORKConsentSignature(forPersonWithTitle: "Participant", dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
    addSignature(signature)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ORKConsentSectionType: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .overview:
      return "Overview"
      
    case .dataGathering:
      return "Data Gathering"
      
    case .privacy:
      return "Privacy"
      
    case .dataUse:
      return "Data Use"
      
    case .timeCommitment:
      return "Time Commitment"
      
    case .studySurvey:
      return "Study Survey"
      
    case .studyTasks:
      return "Study Tasks"
      
    case .withdrawing:
      return "Withdrawing"
      
    case .custom:
      return "Custom"
      
    case .onlyInDocument:
      return "Only In Document"
    }
  }
}
