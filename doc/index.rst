.. _camera-photonicscience:

PhotonicScience
---------------

.. image:: photonicscience-logo.png

Introduction
````````````
TODO

Prerequisite Windows  ??
`````````````````````````

TODO

The CCD camera 4022 has been tested at ESRF on beamline ID11.

Installation & Module configuration
````````````````````````````````````

-  follow first the steps for the linux installation :ref:`linux_installation`

The minimum configuration file is *config.inc* :

.. code-block:: sh

  COMPILE_CORE=1
  COMPILE_SIMULATOR=0
  COMPILE_SPS_IMAGE=1
  COMPILE_ESPIA=0
  COMPILE_FRELON=0
  COMPILE_MAXIPIX=0
  COMPILE_PILATUS=0
  COMPILE_BASLER=0
  COMPILE_PHOTONICSCIENCE=1
  COMPILE_CBF_SAVING=0
  export COMPILE_CORE COMPILE_SPS_IMAGE COMPILE_SIMULATOR \
         COMPILE_ESPIA COMPILE_FRELON COMPILE_MAXIPIX COMPILE_PILATUS \
         COMPILE_BASLER COMPILE_PHOTONICSCIENCE COMPILE_CBF_SAVING

-  start the compilation :ref:`linux_compilation`

-  finally for the Tango server installation :ref:`tango_installation`

Initialisation and Capabilities
````````````````````````````````
In order to help people to understand how the camera plugin has been implemented in LImA this section
provides some important information about the developer's choices.

Camera initialisation
......................

TODO

Std capabilites
................

This plugin has been implement in respect of the mandatory capabilites but with some limitations which
are due to the camera and SDK features.  We only provide here extra information for a better understanding
of the capabilities for Andor cameras.

* HwDetInfo
  
 TODO

* HwSync

 TODO 
  

Optional capabilites
........................
In addition to the standard capabilities, we make the choice to implement some optional capabilities which
are supported by the SDK and the I-Kon cameras. A Shutter control, a hardware ROI and a hardware Binning are available.

* HwShutter

 TODO

* HwRoi

 TODO

* HwBin 

 TODO

Configuration
`````````````

 TODO

How to use
````````````
This is a python code example for a simple test:

.. code-block:: python

  from Lima import PhotonicScience
  from lima import Core

  #               camera library path 
  cam = Xh.Camera('ImageStar4022_v2.5\imagestar4022control.dll')
  hwint = Xh.Interface(cam)
  ct = Core.CtControl(hwint)

  acq = ct.acquisition()

  # configure some hw parameters

  # set some low level configuration

  # setting new file parameters and autosaving mode
  saving=ct.saving()

  pars=saving.getParameters()
  pars.directory='/buffer/lcb18012/opisg/test_lima'
  pars.prefix='test1_'
  pars.suffix='.edf'
  pars.fileFormat=Core.CtSaving.EDF
  pars.savingMode=Core.CtSaving.AutoFrame
  saving.setParameters(pars)

  # now ask for 2 sec. exposure and 10 frames
  acq.setAcqExpoTime(2)
  acq.setNbImages(10) 
  
  ct.prepareAcq()
  ct.startAcq()

  # wait for last image (#9) ready
  lastimg = ct.getStatus().ImageCounters.LastImageReady
  while lastimg !=9:
    time.sleep(1)
    lastimg = ct.getStatus().ImageCounters.LastImageReady
 
  # read the first image
  im0 = ct.ReadImage(0)


  
