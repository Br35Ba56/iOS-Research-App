#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ORKEnvironmentSPLMeterResult.h"
#import "ORKVideoInstructionStep.h"
#import "ORKWaitStep.h"
#import "ORKStepNavigationRule.h"
#import "ORKReviewStep.h"
#import "ORKNavigableOrderedTask.h"
#import "ORKSpeechRecognitionResult.h"
#import "ORKDiscreteGraphChartView.h"
#import "ORKStep.h"
#import "ORKAnswerFormat.h"
#import "ORKCollectionResult.h"
#import "ORKRecorder.h"
#import "ORKFormStepViewController.h"
#import "ORKResult.h"
#import "ORKReactionTimeResult.h"
#import "ORKStroopResult.h"
#import "ORKInstructionStepViewController.h"
#import "ORKTypes.h"
#import "ORKVideoInstructionStepResult.h"
#import "ORKCollector.h"
#import "ORKWaitStepViewController.h"
#import "ORKFileResult.h"
#import "ORKSignatureStep.h"
#import "ORKHolePegTestResult.h"
#import "ORKEnvironmentSPLMeterStep.h"
#import "ORKStepViewController.h"
#import "ORKActiveStepViewController.h"
#import "ORKPageStepViewController.h"
#import "ORKFormStep.h"
#import "ORKRegistrationStep.h"
#import "ORKContinueButton.h"
#import "ORKDefines.h"
#import "ORKInstructionStep.h"
#import "ORKOrderedTask+ORKPredefinedActiveTask.h"
#import "ORKTableStepViewController.h"
#import "ORKSpeechInNoiseStep.h"
#import "ORKChartTypes.h"
#import "ORKVerificationStep.h"
#import "ORKTowerOfHanoiResult.h"
#import "ORKConsentSection.h"
#import "ORKTrailmakingResult.h"
#import "ORKTimedWalkResult.h"
#import "ORKPasscodeViewController.h"
#import "ORKBarGraphChartView.h"
#import "ORKLineGraphChartView.h"
#import "ResearchKit.h"
#import "ORKTaskViewController.h"
#import "ORKActiveStep.h"
#import "ORKGraphChartView.h"
#import "ORKTextButton.h"
#import "ORKConsentSignatureResult.h"
#import "ORKCompletionStepViewController.h"
#import "ORKPSATResult.h"
#import "ORKSignatureResult.h"
#import "ORKVisualConsentStep.h"
#import "ORKPasscodeStep.h"
#import "ORKDataCollectionManager.h"
#import "ORKKeychainWrapper.h"
#import "ORKActiveTaskResult.h"
#import "ORKConsentSharingStep.h"
#import "ORKQuestionStep.h"
#import "ORKQuestionResult.h"
#import "ORKWebViewStep.h"
#import "ORKPageStep.h"
#import "ORKImageCaptureStep.h"
#import "ORKPDFViewerStepViewController.h"
#import "ORKAmslerGridResult.h"
#import "ORKTouchAnywhereStep.h"
#import "ORKBorderedButton.h"
#import "ORKPasscodeResult.h"
#import "ORKToneAudiometryResult.h"
#import "ORKWebViewStepResult.h"
#import "ORKHealthAnswerFormat.h"
#import "ORKRangeOfMotionResult.h"
#import "ORKTableStep.h"
#import "ORKPieChartView.h"
#import "ORKOrderedTask.h"
#import "ORKNavigablePageStep.h"
#import "ORKLoginStepViewController.h"
#import "ORKResultPredicate.h"
#import "ORKVerificationStepViewController.h"
#import "ORKSpatialSpanMemoryResult.h"
#import "ORKConsentReviewStep.h"
#import "ORKTask.h"
#import "ORKConsentSignature.h"
#import "ORKTouchAnywhereStepViewController.h"
#import "ORKDeprecated.h"
#import "ORKLoginStep.h"
#import "ORKTappingIntervalResult.h"
#import "ORKVideoCaptureStep.h"
#import "ORKWebViewStepViewController.h"
#import "ORKConsentDocument.h"
#import "ORKAnswerFormat_Private.h"
#import "ORKAudioRecorder.h"
#import "ORKReactionTimeStep.h"
#import "ORKSpeechRecognitionStep.h"
#import "ORKCustomStepView.h"
#import "ORKHolePegTestRemoveStep.h"
#import "ORKDataLogger.h"
#import "ORKStroopStepViewController.h"
#import "ORKTimedWalkStep.h"
#import "ORKToneAudiometryStepViewController.h"
#import "ORKStepNavigationRule_Private.h"
#import "ORKReviewStepViewController.h"
#import "ORKCollectionResult_Private.h"
#import "ORKSignatureResult_Private.h"
#import "ORKVideoInstructionStepViewController.h"
#import "ORKSpeechRecognitionStepViewController.h"
#import "ORKCountdownStep.h"
#import "ORKConsentDocument_Private.h"
#import "ORKLocationRecorder.h"
#import "ORKStroopStep.h"
#import "ORKdBHLToneAudiometryResult.h"
#import "ResearchKit_Private.h"
#import "ORKHolePegTestPlaceStep.h"
#import "ORKQuestionStepViewController_Private.h"
#import "ORKShoulderRangeOfMotionStep.h"
#import "ORKQuestionResult_Private.h"
#import "ORKOrderedTask_Private.h"
#import "ORKConsentSection_Private.h"
#import "ORKTimedWalkStepViewController.h"
#import "ORKAccelerometerRecorder.h"
#import "ORKHelpers_Private.h"
#import "ORKPedometerRecorder.h"
#import "ORKHTMLPDFPageRenderer.h"
#import "ORKConsentSharingStepViewController.h"
#import "ORKQuestionStepViewController.h"
#import "ORKAmslerGridStep.h"
#import "ORKVisualConsentStepViewController.h"
#import "ORKAmslerGridStepViewController.h"
#import "ORKPasscodeStepViewController.h"
#import "ORKWalkingTaskStep.h"
#import "ORKSpatialSpanMemoryStep.h"
#import "ORKAudioStepViewController.h"
#import "ORKRecorder_Private.h"
#import "ORKTouchRecorder.h"
#import "ORKdBHLToneAudiometryOnboardingStep.h"
#import "ORKTowerOfHanoiStep.h"
#import "ORKHolePegTestRemoveStepViewController.h"
#import "ORKPSATStepViewController.h"
#import "ORKCompletionStep.h"
#import "ORKSignatureStepViewController.h"
#import "ORKCountdownStepViewController.h"
#import "ORKConsentReviewStepViewController.h"
#import "ORKFitnessStepViewController.h"
#import "ORKFitnessStep.h"
#import "ORKdBHLToneAudiometryStep.h"
#import "ORKRangeOfMotionStep.h"
#import "ORKHealthQuantityTypeRecorder.h"
#import "ORKTaskViewController_Private.h"
#import "ORKdBHLToneAudiometryStepViewController.h"
#import "ORKStreamingAudioRecorder.h"
#import "ORKTappingIntervalStepViewController.h"
#import "ORKDeviceMotionRecorder.h"
#import "ORKHealthClinicalTypeRecorder.h"
#import "ORKAudioLevelNavigationRule.h"
#import "ORKWalkingTaskStepViewController.h"
#import "ORKPageStep_Private.h"
#import "ORKPSATStep.h"
#import "ORKResult_Private.h"
#import "ORKTrailmakingStep.h"
#import "ORKErrors.h"
#import "ORKToneAudiometryStep.h"
#import "ORKHolePegTestPlaceStepViewController.h"
#import "ORKPDFViewerStep.h"
#import "ORKSpatialSpanMemoryStepViewController.h"
#import "ORKTappingIntervalStep.h"
#import "ORKImageCaptureStepViewController.h"
#import "ORKAudioStep.h"

FOUNDATION_EXPORT double ResearchKitVersionNumber;
FOUNDATION_EXPORT const unsigned char ResearchKitVersionString[];

