# Shape-Supervised Dimension Reduction (SSDR)



<img src="assets/workflow.png?raw=true" width="600">



## Shape-supervised dimension reduction: Extracting geometry and physics associated features with geometric moments

***Shape reparameterisation with latent variables for shape optimisation***

[Shahroz Khan](https://www.shahrozkhan.info/)\*, [Panagiotis Kaklis](https://www.strath.ac.uk/staff/kaklispanagiotisprof/)\, [Andrea Serani](http://www.inm.cnr.it/people/andrea-serani/)\, [Matteo Diez](http://www.inm.cnr.it/people/matteo-diez/)\, [Konstantinos Kostas](https://nu.edu.kz/faculty/konstantinos-kostas)

[[Paper]](-) [[Presentation]](-) [[Video]](-)


## Overview of the work
Despite the success of design space dimensionality reduction for accelerating computationally demanding shape optimisation processes, the existing approaches, such as PCA, Active-Subspace Method, AutoEncoders, etc., suffer from two critical drawbacks: i) low-levels of robustness, i.e., a non-negligible percentage of designs in the reduced dimensionality subspace corresponds to invalid/infeasible instances, and ii) inability to capture high-level structure information, i.e., high-level features, associated to physics, which would considerably improve performance, are not captured.

Therefore, we propose a shape-supervised dimension reduction (SSDR) approach. To simultaneously tackle these deficiencies, SSDR uses higher-level information about the shape in terms of its geometric integral properties, such as geometric moments and their invariants. Their usage is based on the fact that moments of a shape are intrinsic features of its geometry, and they provide a unifying medium between geometry and physics. To enrich the subspace with latent features associated with shape's geometrical features and physics, we also evaluate a set of composite geometric moments, using the divergence theorem, for appropriate shape decompositions. These moments are combined with the shape modification function to form a Shape Signature Vector (SSV) uniquely representing a shape. Afterwards, the generalised Karhunen-Loève expansion is applied to SSV, embedded in a generalised (disjoint) Hilbert space. This results in the extraction of latent variables retaining the highest geometric and physical variance. These variables are used as new parameters of the shape, which can be used to construct a lower-dimensional shape-supervised subspace. The new subspace
* has not only enhanced representation capacity and compactness to produce a valid and diverse set of design alternatives, respectively,  but
* is also physically informed to improve the convergence rate of the shape optimiser towards an optimal solution. 

## Requirements and Dependencies

* [Matlab](https://uk.mathworks.com/products/matlab.html)

The code of SSDR has been tested on the [Matlab](https://uk.mathworks.com/products/matlab.html) 2020a. It should work on any other version of the Matlab. However, SSDR's functions, `KLE.m` and `sthOrderGeometricMoment.m`, use Matlab's [gpuArray](https://uk.mathworks.com/help/parallel-computing/gpuarray.html) and [parfor](https://uk.mathworks.com/help/parallel-computing/parfor.html), respectively, which may not be compatible for your version of the Matlab version. 

SSDR does not have any external dependencies.

## Usage

The core of SSDR is composed of two main functionalities, evaluation of geometric moments, creation of shape-signature vector (SSV) and implementation of Karhunen-Loève expansion of SSV.   

### Geometric Moments 

Construction of SSV involves a design grid and geometric moments of *s*th-order. An *s*th-order geometric moment *M_pqr* can be evaluated as follows:

<img src="assets/geometricMoment.svg?raw=true" width="400">

where *s=p+q+r*. Moreover, all the moments of a certain can be defined as follows:

<img src="assets/geometricMomentVector.svg?raw=true" width="600">

where **M^s** is the *s*th-order moment vector used in SSV. 

* Use `sthOrderGeometricMoment.m` function to evaluate *s*th-order *M_pqr*.
* Use `sthOrderGeometricMomentVector.m` function to evaluate *s*th-order **M^s**.

The above functions take a closed 3D triangulated mesh in the `.stl` formate to evaluate geometric moments. Test these functions for a [wing](https://drive.google.com/file/d/1JbeBUpt0z9mgZvjvfhNyrhba8cZRoPNZ/view?usp=sharing) and a [ship](https://drive.google.com/file/d/1JxY6qaKqkNBhVjzBuNJeemL42TvxflDX/view?usp=sharing) model. 

### Karhunen-Loève Expansion (KLE)

Once SSV is constructed, `KLE.m` can be used to extract the geometrically- and functionally active latent variables. 

For further details on the usage of these functions and the implementation of SSDR, use the example file `example_shapeSupSubspace.m`, which implements it on a 3D wing example. To run the example, first download the Datasets ([wingMoments](https://drive.google.com/file/d/1zIT9yZIhRh6IV7GXJWn3TRQtL2JaooWs/view?usp=sharing), [wingSamples](https://drive.google.com/file/d/1Zr0FWRbJuCVB55Ivx59VnH7BCCIMRaFO/view?usp=sharing)) and place them in the working folder. 

### Shape Optimisation
Once latent variables are constructed, use the `evlSubspaceLimits.m` function to build the shape-supervised subspace, which can later be used for shape optimisation against any physical quantity of interest.


## Installation
To install the SSDR package, simply download the folder or open the Matlab to clone the repository with the command

```bash
https://github.com/shahrozkhan66/SSDR.git
```

using the following steps:

* Open **Matlab**
* On the **Home tab**, click **New** > **Project** >> **From Git**. The New Project From Source Control dialog box opens.
* Enter `https://github.com/shahrozkhan66/SSDR.git` into the Repository path field.
* In the **Sandbox** field, select the working folder where you want to put the retrieved files for your new project.
* Click **Retrieve** >> **OK** >> **Set Up Project** >> **Next** >> **Finish**.
* Download the Datasets ([wingMoments](https://drive.google.com/file/d/1zIT9yZIhRh6IV7GXJWn3TRQtL2JaooWs/view?usp=sharing), [wingSamples](https://drive.google.com/file/d/1Zr0FWRbJuCVB55Ivx59VnH7BCCIMRaFO/view?usp=sharing)) and place them in the working folder. 
* Run example `example_shapeSupSubspace.m`.
 
 ## Contact
 If you have questions or feedback, contact [Shahroz Khan](https://www.shahrozkhan.info).

## Acknowledgement 
**This work has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Skłodowska-Curie grant "[GRAPES](http://grapes-network.eu/): learninG, pRocessing And oPtimising shapES" (agreement No. 860843).**

## License

Distributed under the GNU GENERAL PUBLIC LICENSE. See LICENSE.txt for more information.
