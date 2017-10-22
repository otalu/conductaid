## What?

<iframe width="560" height="315" src="https://www.youtube.com/embed/Gs7KTd38o4Y" frameborder="0" allowfullscreen></iframe>

ConductAid is a set of wearable devices that help visually impaired musicians
in orchestras, by translating the motions of the conductor as audible feedback
to the musicians.

## Why?

From Ray Charles to Stevie Wonder, from Ronnie Millsap to Andrea Bocelli, many
musicians let the world enjoy their music, despite their visual impairments.

Despite music is a ubiquitous outlet for visually impaired members of the
society, there are no methods in place to allow visually impaired musicians
to perform in orchestras.

ConductAid is aiming to remove the communication barrier between the conductor
and the visually impaired musicians - and is asking your help in doing so.

## How?

![60 BPM Analysis Results](https://raw.githubusercontent.com/otalu/conductaid/master/60bpm_filter_fft.png)


![120 BPM Analysis Results](https://raw.githubusercontent.com/otalu/conductaid/master/120bpm_filter_fft.png)

### Tempo

### Volume

Even though there are various conventions on how a conductor communicates volume
to their orchestra, one of the most common ways is by the size of their motions -
larger motions indicating larger volume.

In order to translate that motion to the musicians, a Fourier Analysis is performed
on the livestream data that is received from the accelerometers, and is filtered
based on the tempo of the movements. Based on this filtering, the amplitude of the
overruling frequency (which is also the tempo of the music piece), is the volume.

Over the course of the music piece, the volume information from a time interval is
averaged and communicated to the musician.

### Cue

## Future Steps

Being a relatively new project with a lot of room for improvement, there are
several future steps that would bring ConductAid closer to being a reality.

### Translating Quantitative Results for the Musicians

Some of the results of the current state of the product are in forms that would
not make sense too much  or would not be too valuable of a feedback for a
musician. For this reason, one of the immediate future steps that can be taken
include translating the quantitative results for volume into terms that would
make sense for a musician.

This requires more research into music theory and collaboration with orchestra
conductors, possibly gathering data from different orchestra conductors and
training the algorithm to distinguish between different sizes of motion patterns.

### Integrating the Current System with Haptic Feedback

Haptic feedback is selected as the mode to communicate information to the
musicians, due to not wanting to impair their hearing with an audible feedback
system; however since no work has been done about this portion of the product yet,
it is one of the priorities of the team, moving forward.

Collaboration with visually impaired musicians is necessary in order to optimize
the reliability and ergonomics of the device, so that it in its most helpful
and beneficial form.

###

## Source Code

ConductAid is an open-source project, and the team appreciates feedback from
anyone who would like to be involved in the improvement of the project.

GitHub: [ConductAid](https://github.com/otalu/conductaid)
