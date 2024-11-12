# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* [Simon Yoo] 
* *email:* [spyoo@ucdavis.edu]

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera follows vessel as described in the position lock stage. The camera stays with the vessel and the cross can be toggled with 'f'.

___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera auto scrolls on the x plane in the positive direction. The vessel does not travel with the camera, and it gets pushed by the auto scroll box if it lags behind. Exported variables are set correctly, allowing the configuration of box make up and autoscroll speed. The box can be toggled. I found their usage of the [clampf function](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/horiz_auto.gd#L17) interesting as I had not heard of or thought of that.

___
### Stage 3 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera follows the player and does not let vessel get more than leash length away, no matter the speed of vessel. All the export variables are set correctly. The camera recenters the vessel when it's not moving, using the catchup speed. The cross can be toggled. I thought that the [logic to prevent stuttering](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/lerp_lock.gd#L24) seemed like a good touch.

___
### Stage 4 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera leads in the direction of player input. All the export variables are set and utilized correctly. Camera does not get further than leash distance away from the vessel. There a configurable delay time before the camera recenters the vessel in its view. The cross can be toggled.

___
### Stage 5 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
When the vessel leaves the inner push box, the camera moves at [push_ratio](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/push_box.gd#L5) (typically slower than the vessel) towards the vessel until the vessel hits the outer push box. When the vessel hits the outer push box, the camera moves at the vessel's speed. All the export variables are set correctly. Both push boxes are toggleable. It's almost perfect, however, I put "Great" due to the camera moving while the vessel moves backwards from the outer pushbox. 
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
Overall, the code was very neat and followed the GDscript style guide. I was only able to find very minor infractions as stated below.

[File Name Conventions](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/horiz_auto.gd#L1) - Files are not snake_case conversions of class name, however, they are similar.

[Floats With no Tailing 0](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/target_focus.gd#L12) - The floats declared have no tailing 0 to distinguish them from integers.

#### Style Guide Exemplars ####
[Proper use of indent levels](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/horiz_auto.gd#L17) - They used two indents to signify the continuation of lines and consistently use one indent level when necessary for other code.

[Avoided Unnecessary Parentheses and Brackets](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/target_focus.gd#L20) - As shown in this function, they avoided using parentheses and brackets in the if statements. 
___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
[Variable Declaration Misplacement](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/lerp_lock.gd#L11) - They declared a variable only used in the draw_logic() function, so they should have declared it in the draw_logic() function rather than globally.

[Left uncommented debug print statement](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/push_box.gd#L64) - What I'm assuming is a leftover print statement from debugging was left uncommented.

#### Best Practices Exemplars ####
[Good Comments](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/target_focus.gd#L3) - Good comments throughout multiple (not all) scripts. These comments helped to understand the logic of the code implemented.

[Good Export Variables](https://github.com/ensemble-ai/exercise-2-camera-control-benyoung32/blob/45556b086574a059972c9fa74a4eb00a75bda24b/Obscura/scripts/camera_controllers/target_focus.gd#L22) - Some of their export variables are used with other variables, like target.velocity. For instance, their lead_speed for their stage 4 camera is calculated using the vessel's velocity. This is a good way of having the variables set up.