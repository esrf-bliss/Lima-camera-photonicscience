.. _camera-photonicscience:

PhotonicScience
---------------

.. image:: photonicscience-logo.png

Introduction
````````````

  "Photonic Science is a high technology independent manufacturer of scientific detector systems covering the range of visible to x-ray and neutron detection. The camera technology offered is wide ranging, from CCD, EMCCD, CMOS to image intensified systems."

The CCD camera 4022 has been tested at ESRF on beamline ID11.

Prerequisite
````````````

TODO

Installation & Module configuration
```````````````````````````````````

Follow the generic instructions in :ref:`build_installation`. If using CMake directly, add the following flag:

.. code-block:: sh

 -DLIMACAMERA_PHOTONICSCIENCE=true

For the Tango server installation, refers to :ref:`tango_installation`.

Initialisation and Capabilities
````````````````````````````````

Implementing a new plugin for new detector is driven by the LIMA framework but the developer has some freedoms to choose which standard and specific features will be made available. This section is supposed to give you the correct information regarding how the camera is exported within the LIMA framework.

Camera initialisation
......................

TODO

Std capabilities
................

This plugin has been implemented in respect of the mandatory capabilites but with some limitations which
are due to the camera and SDK features.  We only provide here extra information for a better understanding
of the capabilities for Andor cameras.

* HwDetInfo

 TODO

* HwSync

 TODO


Optional capabilities
.....................

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
