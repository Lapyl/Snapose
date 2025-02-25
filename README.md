## Project

Snapose is a Walking-Pose KeyPoints Detection App, developed by Lalit A Patel and Laxmi L Patel, and submitted to the Windows on Snapdragon AI Hackathon 2025.

This app can be useful for Gait Analysis for Physical Therapy.

## Files on this Repository

- OpenPoseDemoExeCode.txt : One-line code of OpenPose to detect key points of the body or bodies in a video of a single person or multiple persons
- JsonAnalysis_MultiFace.ipynb : Analysis and animation of key points of bodies in an example video of multiple persons walking
- JsonAnalysis_LaxmiFace.ipynb : Analysis and animation of key points in the video of Laxmi walking while facing the camera 
- JsonAnalysis_LaxmiSide.ipynb : Analysis and animation of key points in the video of Laxmi walking while camera facing a side of Laxmi
- JsonAnalysis_MultiFace.html : Html version of JsonAnalysis_MultiFace.ipynb
- JsonAnalysis_LaxmiFace.html : Html version of JsonAnalysis_LaxmiFace.ipynb
- JsonAnalysis_LaxmiSide.html : Html version of JsonAnalysis_LaxmiSide.ipynb
- FlutterAppMain.dart : main.dart file in a Flutter-Dart app for analysis and animation of key points of bodies
- Audio2Pyttsx.ipynb : Python code for generating mp3 files from narration texts

## Links

- Project Submission on Github: https://devpost.com/software/snapose
- Project Video on YouTube: https://youtu.be/LbkK1GzB5f8
- Hackathon Information on Devpost: https://wos-ai.devpost.com
- Hackathon Information on Qualcomm: https://www.qualcomm.com/developer/windows-on-snapdragon
- Qualcomm AI Hub: https://app.aihub.qualcomm.com
- OpenPose Repository on GitHub: https://github.com/CMU-Perceptual-Computing-Lab/openpose
- Source of a background music: https://www.nasa.gov/wp-content/uploads/2024/05/carina-aug-3.wav

## Inspiration

We felt that physical therapists like our daughter Ruchi and their patients can greatly benefit from a gait analysis. A gait analysis is an evaluation of how the patient walks. An appropriate deep-learning AI based tool can broaden the availability and simplify the process of gait analysis.

## Narration

- Our objective in this project was to develop a Windows desktop app to: (1) detect key points of the body while a person is walking, (2) analyze x and y coordinates of the key points in different frames, and (3) infer whether the person is walking correctly. We have named our proposed app Snapose.
- After comparing several possible options for developing an app, we have selected Flutter with Dart, because it is a user-friendly approach with excellent documentation, and it can produce apps for Windows, Linux, iOS, or Android. We have designed the GUI of our Flutter-Dart-based app, and have written some of the necessary codes. However, we have so far not completed and finalized all codes for the app.
- Qualcomm has a few deep-learning models that can detect some key points of the body. However, Qualcomm’s models so far cannot suit for analyzing the pattern of walking. We found Carnegie Melon University's OpenPose algorithm to be most suitable for our objective. We used one of the laptops remotely provided by Qualcomm for applying OpenPose on videos of people walking. The Qualcomm laptop’s Snapdragon chip architecture and sizable RAM could process videos much faster than on our own Intel chip based computers.
- OpenPose is available as a Windows executable .exe file. A simple one-line command-line code can process a video, detect key points of bodies of multiple people, and produce .json files, one file for each frame of the video. We used an example video of multiple people walking.
- To avoid possible mix-up of coordinates of key points, we created and analyzed our own video of Laxmi walking, with the camera facing on her front.
- To make it possible to analyze movements of arms with respect to feet, we created and analyzed our own video of Laxmi walking, with the camera facing on her side.
- We wrote a Python code to analyze the .json files from the multiple people video. We found that the selected person raises feet more than appropriate. Using Matplotlib package, we created an animation of key points of the selected person.
- We tweaked the Python code to analyze the .json files from the video of Laxmi facing the camera. We found that Laxmi raises feet correctly.
- We used the same Python code to analyze the .json files from the video with the camera on a side of Laxmi. Here also we found that Laxmi raises feet correctly.