# AM-FM-PM-using-MATLAB-GUIDE
In this proect I have designed a GUI using MATLAB to generate Amplitude Modulation, Frequency Modulation and Phase Modulation signals, under the course **Communication Engineering and Coding Theory Lab (CS491)**.

___

### Theory
- [Amplitude Modulation](https://en.wikipedia.org/wiki/Amplitude_modulation)
- [Frequency modulation](https://en.wikipedia.org/wiki/Frequency_modulation)
- [Phase modulation](https://en.wikipedia.org/wiki/Phase_modulation)

___

### Some derivations
#### Frequency modulation
In case of frequency modulation, frequency of carrier signal is valid accordance with the instantaneous amplitude of the message signal

f<sub>i</sub> = f<sub>c</sub> + k<sub>f</sub>𝓍(t)                   [k<sub>f</sub> = frequency sensitivity]

2πf<sub>i</sub> = 2πf<sub>c</sub> + 2πk<sub>f</sub>𝓍(t)

ω<sub>i</sub> = ω<sub>c</sub> + 2πk<sub>f</sub>𝓍(t)

∫ω<sub>i</sub>dt = ∫ω<sub>c</sub>dt + 2πk<sub>f</sub> ∫𝓍(t).dt

ω<sub>i</sub> = ω<sub>c</sub>t + 2πk<sub>f</sub> ∫𝓍(t).dt

S𝓍<sub>m</sub>(t) = A<sub>c</sub>cos(ω<sub>c</sub> + 2πk<sub>f</sub>  ∫𝓍(t).dt)

This is the generalized expression of FM signal

𝓍(t) = A<sub>m</sub>cos ω<sub>m</sub>t

S<sub>FM</sub>(t) = A<sub>c</sub>cos(ω<sub>c</sub>t + 2πk<sub>f</sub> ∫A<sub>m</sub>cos ω<sub>m</sub>t.dt)

= A<sub>c</sub>cos(ω<sub>c</sub>t + (2πk<sub>f</sub>A<sub>m</sub>/2πf<sub>m</sub>)sin ω<sub>m</sub>t)

= A<sub>c</sub>cos(ω<sub>c</sub>t + (k<sub>f</sub>A<sub>m</sub>)sin ω<sub>m</sub>t)
                  
S<sub>FM</sub>(t) = A<sub>c</sub>cos(ω<sub>c</sub>t + 𝛽sin ω<sub>m</sub>t)        [𝛽 = k<sub>f</sub>/f<sub>m</sub> (Modulation Index)]

There are two types of FM:-
    i) Narrow Band FM (NBFM) 𝛽<1
    ii) Wide Band FM (NBFM) 𝛽>1

#### Phase modulation
The message signal is given by

𝓍(t) = A<sub>m</sub>cos ω<sub>m</sub>t……………(i)

The Carrier signal is given by

c(t) = A<sub>c</sub>cos ω<sub>c</sub>t……………(ii)

Then the phase modulation signal is given by 

S<sub>PM</sub>(t) = A<sub>c</sub>cosჶ<sub>i</sub> ……………..(iii)

where

ჶ<sub>i</sub>  = ω<sub>c</sub>t + k<sub>p</sub>𝓍(t).....................(iv)

Putting the value ჶ<sub>i</sub> in equation (iii) we get,

S<sub>PM</sub> = A<sub>c</sub>cos(ω<sub>c</sub>t + k<sub>p</sub>𝓍(t))

= A<sub>c</sub>cos(ω<sub>c</sub>t + k<sub>p</sub>A<sub>m</sub>cosω<sub>m</sub>t)

= A<sub>c</sub>cos(ω<sub>c</sub>t + 𝛽cosω<sub>m</sub>t) ……….(v)

where

k<sub>p</sub> = Phase sensitivity factor

p = Modulation index of phase

𝛽 = k<sub>p</sub>A<sub>m</sub>
___


### The interface
The interface of the program consists of a single window (GUIDE .fig file), containing a graphical plot space (GUIDE axes), edit boxes to take inputs for amplitude, frequency of the message and carrier signals, along with the modulation index, a drop down menu (GUIDE popupmenu) to select the type of signal, and buttons to choose between AM, FM and PM.

The user can feed in the values in the edit box, choose the type of signal, and click on the desired type of modulation to have the waveform displayed.

##### GUIDE
https://in.mathworks.com/help/matlab/creating_guis/about-the-simple-guide-gui-example.html
