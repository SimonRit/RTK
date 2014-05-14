/*=========================================================================
 *
 *  Copyright RTK Consortium
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *         http://www.apache.org/licenses/LICENSE-2.0.txt
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *=========================================================================*/

#ifndef __rtkFourDConjugateGradientConeBeamReconstructionFilter_h
#define __rtkFourDConjugateGradientConeBeamReconstructionFilter_h

#include "rtkBackProjectionImageFilter.h"
#include "rtkForwardProjectionImageFilter.h"
#include "rtkIterativeConeBeamReconstructionFilter.h"
#include "rtkConjugateGradientImageFilter.h"
#include "rtkFourDReconstructionConjugateGradientOperator.h"

#include <itkExtractImageFilter.h>
#include <itkMultiplyImageFilter.h>
#include <itkSubtractImageFilter.h>
#include <itkTimeProbe.h>

namespace rtk
{

/** \class FourDConjugateGradientConeBeamReconstructionFilter
 * \brief 4D reconstruction using conjugate gradient optimization
 *
 *
 * \author Cyril Mory
 *
 * \ingroup ReconstructionAlgorithm
 */
template<class VolumeSeriesType, class ProjectionStackType>
class ITK_EXPORT FourDConjugateGradientConeBeamReconstructionFilter :
  public rtk::IterativeConeBeamReconstructionFilter<VolumeSeriesType, ProjectionStackType>
{
public:
  /** Standard class typedefs. */
  typedef FourDConjugateGradientConeBeamReconstructionFilter                   Self;
  typedef IterativeConeBeamReconstructionFilter<VolumeSeriesType, ProjectionStackType>     Superclass;
  typedef itk::SmartPointer<Self>                            Pointer;
  typedef itk::SmartPointer<const Self>                      ConstPointer;

  /** Some convenient typedefs. */
  typedef VolumeSeriesType      InputImageType;
  typedef VolumeSeriesType      OutputImageType;
  typedef ProjectionStackType   VolumeType;

  /** Typedefs of each subfilter of this composite filter */
  typedef rtk::ForwardProjectionImageFilter< VolumeType, ProjectionStackType >                      ForwardProjectionFilterType;
  typedef rtk::BackProjectionImageFilter< ProjectionStackType, VolumeType >                         BackProjectionFilterType;
  typedef rtk::ConjugateGradientImageFilter<VolumeSeriesType>                                       ConjugateGradientFilterType;
  typedef itk::MultiplyImageFilter<VolumeSeriesType>                                                MultiplyVolumeFilterType;
  typedef rtk::FourDReconstructionConjugateGradientOperator<VolumeSeriesType, ProjectionStackType>  CGOperatorFilterType;
  typedef rtk::ProjectionStackToFourDImageFilter<VolumeSeriesType, ProjectionStackType>             ProjStackToFourDFilterType;

  /** Standard New method. */
  itkNewMacro(Self)

  /** Runtime information support. */
  itkTypeMacro(FourDConjugateGradientConeBeamReconstructionFilter, itk::ImageToImageFilter)

  /** Get / Set the object pointer to projection geometry */
  itkGetMacro(Geometry, ThreeDCircularProjectionGeometry::Pointer)
  itkSetMacro(Geometry, ThreeDCircularProjectionGeometry::Pointer)

  void PrintTiming(std::ostream& os) const;

  /** Get / Set the number of iterations. Default is 3. */
  itkGetMacro(NumberOfIterations, unsigned int)
  itkSetMacro(NumberOfIterations, unsigned int)

  /** Set/Get the 4D image to be updated.*/
  void SetInputVolumeSeries(const VolumeSeriesType* VolumeSeries);
  typename VolumeSeriesType::ConstPointer GetInputVolumeSeries();

  /** Set/Get the stack of projections  */
  void SetInputProjectionStack(const VolumeType* Projection);
  typename VolumeType::ConstPointer GetInputProjectionStack();

  /** Pass the ForwardProjection filter to the conjugate gradient operator */
  void SetForwardProjectionFilter (int _arg);

  /** Pass the backprojection filter to the conjugate gradient operator and to the filter generating the B of AX=B */
  void SetBackProjectionFilter (int _arg);

  /** Pass the interpolation weights to subfilters */
  void SetWeights(const itk::Array2D<float> _arg);

protected:
  FourDConjugateGradientConeBeamReconstructionFilter();
  ~FourDConjugateGradientConeBeamReconstructionFilter(){}

  virtual void GenerateOutputInformation();

  virtual void GenerateData();

  /** The two inputs should not be in the same space so there is nothing
   * to verify. */
  virtual void VerifyInputInformation() {}

  /** Pointers to each subfilter of this composite filter */
  typename ForwardProjectionFilterType::Pointer             m_ForwardProjectionFilter;
  typename BackProjectionFilterType::Pointer                m_BackProjectionFilter;
  typename BackProjectionFilterType::Pointer                m_BackProjectionFilterForB;
  typename MultiplyVolumeFilterType::Pointer                m_ZeroMultiplyFilter;
  typename ConjugateGradientFilterType::Pointer             m_ConjugateGradientFilter;
  typename CGOperatorFilterType::Pointer                    m_CGOperator;
  typename ProjStackToFourDFilterType::Pointer              m_ProjStackToFourDFilter;

private:
  //purposely not implemented
  FourDConjugateGradientConeBeamReconstructionFilter(const Self&);
  void operator=(const Self&);

  /** Geometry object */
  ThreeDCircularProjectionGeometry::Pointer m_Geometry;

  /** Number of projections processed at a time. */
  unsigned int m_NumberOfIterations;

}; // end of class

} // end namespace rtk

#ifndef ITK_MANUAL_INSTANTIATION
#include "rtkFourDConjugateGradientConeBeamReconstructionFilter.txx"
#endif

#endif
