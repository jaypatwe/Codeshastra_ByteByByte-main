import random
import cv2
import numpy as np
import time
import mediapipe as mp
from ultralytics import YOLO

# Grabbing the Holistic Model from Mediapipe and
# Initializing the Model
mp_holistic = mp.solutions.holistic
holistic_model = mp_holistic.Holistic(
    min_detection_confidence=0.5, min_tracking_confidence=0.5
)

# Initializing the drawing utils for drawing the facial landmarks on image
mp_drawing = mp.solutions.drawing_utils

# List of classes you want to detect
desired_classes = ["cup", "fork", "knife", "bottle"]

# opening the file in read mode
my_file = open("utils/coco.txt", "r")
# reading the file
data = my_file.read()
# replacing end splitting the text | when newline ('\n') is seen.
class_list = data.split("\n")
my_file.close()

# Generate random colors for class list
detection_colors = []
for i in range(len(class_list)):
    r = random.randint(0, 255)
    g = random.randint(0, 255)
    b = random.randint(0, 255)
    detection_colors.append((b, g, r))

# load a pretrained YOLOv8n model
model = YOLO("weights/yolov8n.pt", "v8")

# Vals to resize video frames | small frame optimise the run
frame_wid = 640
frame_hyt = 480

# (0) in VideoCapture is used to connect to your computer's default camera
capture = cv2.VideoCapture(0)

# Initializing current time and precious time for calculating the FPS
previousTime = 0
currentTime = 0

while capture.isOpened():
    # capture frame by frame
    ret, frame = capture.read()

    # resizing the frame for better view
    frame = cv2.resize(frame, (800, 600))

    # Converting the from BGR to RGB
    image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # Making predictions using holistic model
    # To improve performance, optionally mark the image as not writeable to
    # pass by reference.
    image.flags.writeable = False
    results = holistic_model.process(image)
    image.flags.writeable = True

    # Converting back the RGB image to BGR
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

    # Drawing the Facial Landmarks
    mp_drawing.draw_landmarks(
        image,
        results.face_landmarks,
        mp_holistic.FACEMESH_CONTOURS,
        mp_drawing.DrawingSpec(color=(0, 180, 255), thickness=1, circle_radius=1),
        mp_drawing.DrawingSpec(color=(0, 180, 255), thickness=1, circle_radius=1),
    )

    # Drawing Right hand Land Marks
    mp_drawing.draw_landmarks(
        image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS
    )

    # Drawing Left hand Land Marks
    mp_drawing.draw_landmarks(
        image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS
    )

    # Predict on image
    detect_params = model.predict(source=[frame], conf=0.45, save=False)

    # Convert tensor array to numpy
    DP = detect_params[0].numpy()

    if len(DP) != 0:
        for i in range(len(detect_params[0])):
            boxes = detect_params[0].boxes
            box = boxes[i]  # returns one box
            clsID = box.cls.numpy()[0]
            conf = box.conf.numpy()[0]
            bb = box.xyxy.numpy()[0]

            # Check if the detected class is in the desired classes list
            if class_list[int(clsID)] in desired_classes:
                cv2.rectangle(
                    image,
                    (int(bb[0]), int(bb[1])),
                    (int(bb[2]), int(bb[3])),
                    detection_colors[int(clsID)],
                    3,
                )

                # Display class name and confidence
                font = cv2.FONT_HERSHEY_COMPLEX
                cv2.putText(
                    image,
                    class_list[int(clsID)] + " " + str(round(conf, 3)) + "%",
                    (int(bb[0]), int(bb[1]) - 10),
                    font,
                    1,
                    (255, 255, 255),
                    2,
                )

    # Calculating the FPS
    currentTime = time.time()
    fps = 1 / (currentTime - previousTime)
    previousTime = currentTime

    # Displaying FPS on the image
    cv2.putText(
        image,
        str(int(fps)) + " FPS",
        (10, 70),
        cv2.FONT_HERSHEY_COMPLEX,
        1,
        (0, 255, 0),
        2,
    )

    # Display the resulting image
    cv2.imshow("Facial and Hand Landmarks", image)

    # Get the actual offset values of a point in the canvas
    # x = results.right_hand_landmarks.landmark[mp_holistic.HandLandmark.WRIST].x
    # y = results.right_hand_landmarks.landmark[mp_holistic.HandLandmark.WRIST].y
    # z = results.right_hand_landmarks.landmark[mp_holistic.HandLandmark.WRIST].z

    # # Print the offset values
    # print("Wrist Offset Values - X:", x, "Y:", y, "Z:", z)

    if results.right_hand_landmarks:
        # for diff index finger
        yIndexFingerDip = results.right_hand_landmarks.landmark[
            mp_holistic.HandLandmark.INDEX_FINGER_DIP
        ].y  # 8
        yMiddleFingerPip = results.right_hand_landmarks.landmark[
            mp_holistic.HandLandmark.MIDDLE_FINGER_PIP
        ].y  # 10

        yThumbTip = results.right_hand_landmarks.landmark[
            mp_holistic.HandLandmark.THUMB_TIP
        ].y  # 4
        yIndexFingerPip = results.right_hand_landmarks.landmark[
            mp_holistic.HandLandmark.INDEX_FINGER_PIP
        ].y  # 6

        # facepoint = results.face_landmarks.landmark[58].y

        # Multiply yIndexFingerDip and yMiddleFingerPip by 10 and keep only the part before the decimal
        yIndexFingerDip = int(yIndexFingerDip * 10)
        yMiddleFingerPip = int(yMiddleFingerPip * 10)

        yThumbTip = int(yThumbTip * 10)
        yIndexFingerPip = int(yIndexFingerPip * 10)

        diffIndexFinger = abs(yIndexFingerDip - yMiddleFingerPip)
        diffThumb = abs(yThumbTip - yIndexFingerPip)

        # Print UNPRESSED or PRESSED based on the difference
        if diffIndexFinger >= 0.2:
            print("UNPRESSED")
            cv2.putText(image, "Incorrectly Pressed", (10, 100), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 255), 2)
            cv2.imshow("Facial and Hand Landmarks", image)
        if diffThumb >= 0.25:
            print("UNPRESSED")
            cv2.putText(image, "Incorrectly Pressed", (10, 100), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 255), 2)
            cv2.imshow("Facial and Hand Landmarks", image)

        else:
            print("************** PRESSED **************")
            cv2.putText(image, "Correctly Pressed", (10, 150), cv2.FONT_HERSHEY_COMPLEX, 1, (64, 255, 0), 2)
            cv2.imshow("Facial and Hand Landmarks", image)

    else:
        print("Incorrect Orientation / Hand not detected!")
        cv2.putText(image, "Incorrect Position / Hand not detected!", (10, 200), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 165, 0), 2)
        cv2.imshow("Facial and Hand Landmarks", image)     

    if results.right_hand_landmarks and results.face_landmarks:
        facepoint = results.face_landmarks.landmark[58].y
        yface = int(facepoint * 10)
        diffface = abs(yface - yThumbTip)
        if diffface > 0.2:
            print("Distance between face and thumb is greater than 0.2")
            cv2.putText(image, "Distance is far between thumb and face!", (10, 250), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 255), 2)
            cv2.imshow("Facial and Hand Landmarks", image)        

        else:
            print("Everything seems fine.")
            cv2.putText(image, "Everything seems fine!", (10, 250), cv2.FONT_HERSHEY_COMPLEX, 1, (64, 255, 0), 2)
            cv2.imshow("Facial and Hand Landmarks", image)     

    # Enter key 'q' to break the loop
    if cv2.waitKey(5) & 0xFF == ord("q"):
        break

# When all the process is done
# Release the capture and destroy all windows
capture.release()
cv2.destroyAllWindows()
