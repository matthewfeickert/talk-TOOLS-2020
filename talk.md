class: middle, center, title-slide
count: false

# `pyhf`: pure-Python implementation of HistFactory with tensors and automatic differentiation

<br>

.huge.blue[Matthew Feickert]<br>
.huge[(University of Illinois at Urbana-Champaign)]
<br><br>
[matthew.feickert@cern.ch](mailto:matthew.feickert@cern.ch)

[Tools for High Energy Physics and Cosmology 2020 Workshop](https://indico.cern.ch/event/955391/contributions/4075505/)

November 3rd, 2020

---
# Why is the likelihood important?

.kol-1-2.width-90[
<br>
- High information-density summary of analysis
- Almost everything we do in the analysis ultimately affects the likelihood and is encapsulated in it
   - Trigger
   - Detector
   - Combined Performance / Physics Object Groups
   - Systematic Uncertainties
   - Event Selection
- Unique representation of the analysis to reuse and preserve
]
.kol-1-2.width-100[
<br><br>
[![likelihood_connections](figures/likelihood_connections.png)](https://indico.cern.ch/event/839382/contributions/3521168/)
]

---
# Partial likelihoods have been published/preserved

.kol-1-2[
.center.width-95[[![CMS_partial_likelihood](figures/CMS_partial_likelihood.png)](https://cds.cern.ch/record/2242860)]
.center[([CMS, 2017](https://cds.cern.ch/record/2242860))]
]
.kol-1-2[
<br>
<br>
.center.width-100[[![CERN_Analysis_Preservation.png](figures/CERN_Analysis_Preservation.png)](https://home.cern/news/news/knowledge-sharing/new-open-release-allows-theorists-explore-lhc-data-new-way)]
.center[CERN Analysis Preservation implements FAIR data]

.center[([CERN, CHEP 2019](https://indico.cern.ch/event/773049/contributions/3476165/))]
]

---
# Full likelihood serialization...

.center[...making good on [19 year old agreement to publish likelihoods](https://indico.cern.ch/event/746178/contributions/3396797/)]

.center.width-90[
[![likelihood_publishing_agreement](figures/likelihood_publishing_agreement.png)](https://cds.cern.ch/record/411537)
]

.center[([1st Workshop on Confidence Limits, CERN, 2000](http://inspirehep.net/record/534129))]

.bold[This hadn't been done in HEP until 2019]
- In an "open world" of statistics this is a difficult problem to solve
- What to preserve and how? All of ROOT?
- Idea: Focus on a single more tractable binned model first

---
# Enter HistFactory and `pyhf`

$$
f\left(\mathrm{data}\middle|\mathrm{parameters}\right) =  f\left(\vec{n}, \vec{a}\middle|\vec{\eta}, \vec{\chi}\right) = \color{blue}{\prod\_{c \\,\in\\, \textrm{channels}} \prod\_{b \\,\in\\, \textrm{bins}\_c} \textrm{Pois} \left(n\_{cb} \middle| \nu\_{cb}\left(\vec{\eta}, \vec{\chi}\right)\right)} \\,\color{red}{\prod\_{\chi \\,\in\\, \vec{\chi}} c\_{\chi} \left(a\_{\chi}\middle|\chi\right)}
$$

.bold[Use:] Multiple disjoint _channels_ (or regions) of binned distributions with multiple _samples_ contributing to each with additional (possibly shared) systematics between sample estimates

.center[HistFactory is used ubiquitously in binned analyses]
.center[Focus on this flexible p.d.f. template rather than "open world" of models]
.center[.bold[This is a _mathematical_ representation!] Nowhere is any software spec defined]

.bold[`pyhf`: HistFactory in pure Python hardware accelerated with autodiff] [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1169739.svg)](https://doi.org/10.5281/zenodo.1169739) ([how to cite](https://scikit-hep.org/pyhf/citations.html#citation))
.kol-3-5[
.width-40[[![pyhf_logo](https://iris-hep.org/assets/logos/pyhf-logo.png)](https://github.com/scikit-hep/pyhf)]
.width-55[[![pyhf_PyPI](figures/pyhf_PyPI.png)](https://pypi.org/project/pyhf/)]
]
.kol-2-5[
.grid[
.kol-1-3.center[
.circle.width-80[![Lukas](figures/collaborators/heinrich.jpg)]

.center[[Lukas Heinrich](https://github.com/lukasheinrich)]

CERN
]
.kol-1-3.center[
.circle.width-80[![Matthew](https://avatars2.githubusercontent.com/u/5142394)]

.center[[Matthew Feickert](https://www.matthewfeickert.com/)]

Illinois
]
.kol-1-3.center[
.circle.width-70[![Giordon](figures/collaborators/stark.jpg)]

.center[[Giordon <br>Stark](https://github.com/kratsg)]

UCSC SCIPP
]
]
]

---
# JSON spec fully describes the HistFactory model

.kol-1-4.width-100[
- Human & machine readable .bold[declarative] statistical models
- Industry standard
   - Will be with us forever
- Parsable by every language
   - Highly portable
   - Bidirectional translation <br>with ROOT
- Versionable and easily preserved
   - JSON Schema [describing<br> HistFactory specification](https://scikit-hep.org/pyhf/likelihood.html#bibliography)
   - Attractive for analysis preservation
   - Highly compressible
]
.kol-3-4.center[
.width-105[![demo_JSON](figures/carbon_JSON_spec_annotated.png)]

.center[[`JSON` defining a single channel, two bin counting experiment with systematics](https://scikit-hep.org/pyhf/likelihood.html#toy-example)]
]

---
# ATLAS validation and publication of likelihoods

.kol-1-2[
.center.width-100[[![ATLAS_PUB_Note_title](figures/ATLAS_PUB_Note_title.png)](https://cds.cern.ch/record/2684863)]

.center.width-90[[![overlay_multiplex_contour](figures/overlay_multiplex_contour.png)](https://cds.cern.ch/record/2684863)]

<br>
.center[(ATLAS, 2019)]
]
.kol-1-2[
.center.width-100[[![CERN_news_story](figures/CERN_news_story.png)](https://home.cern/news/news/knowledge-sharing/new-open-release-allows-theorists-explore-lhc-data-new-way)]
.center[(CERN, 2020)]
]

---
# JSON Patch for signal model (reinterpretation)
<!--  -->
.center[JSON Patch gives ability to .bold[easily mutate model]]
.center[Think: test a .bold[new theory] with a .bold[new patch]!]
.center[(c.f. [Lukas Heinrich's RECAST talk from Snowmass 2021 Computational Frontier Workshop](https://indico.fnal.gov/event/43829/contributions/193817/))]
<br>
.center[Combined with RECAST gives powerful tool for .bold[reinterpretation studies]]
<!--  -->
.kol-1-5[
<br>
<br>
<br>
<br>
.center.width-100[![measurement_cartoon](figures/measurement_cartoon.png)]
.center[Signal model A]
]
.kol-3-5[
<!-- Using Perl style in Carbon -->
.center.width-100[![signal_reinterpretation](figures/carbon_reinterpretation.png)]
]
.kol-1-5[
<br>
<br>
<br>
<br>
.center.width-100[![reinterpretation_cartoon](figures/reinterpretation_cartoon.png)]
.center[Signal model B]
]

---
# Likelihoods preserved on HEPData

- Background-only model JSON stored
- Hundreds of signal model JSON Patches stored together as a [`pyhf` "patch set" file](https://scikit-hep.org/pyhf/_generated/pyhf.patchset.PatchSet.html)
- Together are able to publish and fully preserve the full likelihood (with own DOI! .width-20[[![DOI](https://img.shields.io/badge/DOI-10.17182%2Fhepdata.90607.v2%2Fr2-blue.svg)](https://doi.org/10.17182/hepdata.90607.v2/r2)] )

.kol-3-5[
[.center.width-100[![HEPData_likelihoods](figures/HEPData_likelihoods.png)]](https://www.hepdata.net/record/ins1755298?version=3)
]
.kol-2-5[
<br>
<br>
.center.width-100[[![carbon_tree_likelihood_archive](figures/carbon_tree_likelihood_archive.png)](https://www.hepdata.net/record/ins1755298?version=3)]
]

---
# ...can be used from HEPData

- Background-only model JSON stored
- Hundreds of signal model JSON Patches stored together as a [`pyhf` "patch set" file](https://scikit-hep.org/pyhf/_generated/pyhf.patchset.PatchSet.html)
<!-- - Together are able to publish and fully preserve the full likelihood (with own DOI! .width-20[[![DOI](https://img.shields.io/badge/DOI-10.17182%2Fhepdata.90607.v2%2Fr2-blue.svg)](https://doi.org/10.17182/hepdata.90607.v2/r2)] ) -->
- Together are able to publish and fully preserve the full likelihood (with own DOI! .width-20[[![DOI](https://img.shields.io/badge/DOI-10.17182%2Fhepdata.90607.v2%2Fr2-blue.svg)](https://doi.org/10.17182/hepdata.90607.v2)] )

.center.width-90[![HEPData_streamed_likelihoods](figures/carbon_patchset_example.png)]

---
# Full likelihoods provide tools
.kol-3-5[
- Have seen in this workshop that using `pyhf` JSON workspaces can offer advantages
- Tools for combination:
   - 3L+compressed combination:
      - ["Workspaces as JSON inputs to `pyhf` → speedy!"](https://indico.cern.ch/event/938782/contributions/4022820/) (live page C. Potter, J. Lorenz)
      - c.f. [Carlo Gottardo live page contribution](https://indico.cern.ch/event/945936/contributions/3974713/)
- Tools for reinterpretations:
   - [pMSSM scans comparison of full and simplified likelihoods](https://indico.cern.ch/event/938782/contributions/4014052/) (live page E. Schanet, J. Lorenz)

.center.width-45[[![pMSSM_model_scans_pyhf](figures/pMSSM_model_scans_pyhf.png)](https://indico.cern.ch/event/938782/contributions/4014052/)]
]
.kol-2-5[
- Workflow currently focusing on using [`pyhf xml2json`](https://scikit-hep.org/pyhf/cli.html#pyhf-xml2json) to move from `HistFitter` workspace to `pyhf` JSON

.center.width-90[[![histfitter_to_JSON_workflow](figures/histfitter_to_JSON_workflow.png)](https://indico.cern.ch/event/938782/contributions/4023781/)]

.center[[First steps in pyhf for SUSY EWK 2L0J search](https://indico.cern.ch/event/938782/contributions/4023781/) (live page Daniel Noel)]

- Might consider looking at [IRIS-HEP project `cabinetry`](https://iris-hep.org/projects/cabinetry.html) (lead dev: Alex Held, ATLAS)
   - Still WIP but early feedback and contributions welcome
]

---
# Rapid adoption in ATLAS...
<!--  -->
.kol-1-3[
- Four ATLAS analyses with full likelihoods published to HEPData
- ATLAS SUSY will be continuing to publish full Run 2 likelihoods
]
.kol-2-3[
- direct staus, [doi:10.17182/hepdata.89408](https://doi.org/10.17182/hepdata.89408) (2019)
- sbottom multi-b, [doi:10.17182/hepdata.91127](https://doi.org/10.17182/hepdata.91127) (2019)
- 1Lbb, [doi:10.17182/hepdata.92006](https://doi.org/10.17182/hepdata.92006) (2019)
- 3L eRJR, [doi:10.17182/hepdata.90607.v2](https://doi.org/10.17182/hepdata.90607.v2) (2020)
]
.kol-1-1[
.kol-1-1[
.kol-1-2[
.center.width-70[[![SUSY_EWK_3L_validation](figures/SUSY_RPV_HistFitter.png)](https://indico.cern.ch/event/905793/contributions/3811068/)]
]
.kol-1-2[
.center.width-70[[![SUSY_EWK_3L_validation](figures/SUSY_RPV_pyhf.png)](https://indico.cern.ch/event/905793/contributions/3811068/)]
]
]
.center.smaller[SUSY [EWK 3L RPV](https://atlas.cern/updates/physics-briefing/fantastic-decays-and-where-find-them) analysis ([ATLAS-CONF-2020-009](https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/CONFNOTES/ATLAS-CONF-2020-009/)): Exclusion curves as a function of mass and branching fraction to $Z$ bosons]
]

---
# ...and by theory

.kol-1-3[
- `pyhf` likelihoods discussed in
   - [Les Houches 2019 Physics at TeV Colliders: New Physics Working Group Report](https://inspirehep.net/literature/1782722)
   - [Higgs boson potential at colliders: status and perspectives](https://inspirehep.net/literature/1757043)
- [SModelS](https://smodels.github.io/) team has implemented a `SModelS`/`pyhf` interface [[arXiv:2009.01809](https://inspirehep.net/literature/1814793)]
   - tool for interpreting simplified-model results from the LHC
   - designed to be used by theorists
]
.kol-2-3[
.center.width-100[[![sabine_workshop_slide](figures/sabine_workshop_slide.png)](https://inspirehep.net/literature/1814793)]
.center.smaller[[Feedback on use of public Likelihoods](https://indico.cern.ch/event/957797/contributions/4026032/), Sabine Kraml<br>(Open Theory Feedback Session)]
<!--  -->
]
- Have produced comparison for direct stau production search ([ATLAS-SUSY-2018-04](https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-04/)) [published likelihood](https://www.hepdata.net/record/ins1765529)
   - Compare simplified likelihood (`SModelS`) to full likelihood (`pyhf`)

---
# Full likelihood plans and ideas

.kol-2-5[
- SUSY plans to .bold[continue to publish] full likelihoods for full Run 2
- Consider .bold[open sourcing tools] to reduce full likelihoods to simplified likelihoods and publishing them
   - c.f. [live page contribution from Eric Schanet and Jeanette Lorenz](https://indico.cern.ch/event/938782/contributions/4014052/)
   - Sabine has asked for "next to simplified" as Gaussian approximation doesn't work so well, and the skew information is quite important
- Consider a .bold[RECAST adjacent] framework: "pMSSMCast"
- Nuisance parameter coordination and standarization (ask from Sabine)
- If you have questions on making full likelihoods get in contact with the .bold[`pyhf` dev team]
]
.kol-3-5[
.center.width-100[[![sabine_going_further_slide](figures/sabine_going_further_slide.png)](https://indico.cern.ch/event/957797/contributions/4026032/)]
.center.width-100[[![sabine_thanks_slide](figures/sabine_thanks_slide.png)](https://indico.cern.ch/event/957797/contributions/4026032/)]
.center.smaller[[Feedback on use of public Likelihoods](https://indico.cern.ch/event/957797/contributions/4026032/), Sabine Kraml]
]

---
# Summary
<!--  -->
- .bold[JSON specification] of `pyhf` likelihoods
   - human/machine readable, versionable, HEPData friendly, orders of magnitude smaller, long term preservation
- .bold[Bidirectional translation] of likelihood specifications
   - ROOT workspaces ↔ `pyhf` JSON
- Within 1 year of ATLAS publishing .bold[first full likelihood] ATLAS has published 4!
   - Continued publications from .bold[ATLAS SUSY full Run 2 results]
- .bold[Open publication] on HEPData, reuse and .bold[reinterpretation] with SModelS and RECAST .bold[very valuable]

.kol-1-2.center.width-85[
[![PUB_note_cover](figures/PUB_note_cover.png)](https://cds.cern.ch/record/2684863)
([ATLAS, 2019](https://cds.cern.ch/record/2684863))
]
.kol-1-2.center.width-80[
[![SModelS_preliminary](figures/SModelS_figure1.png)](https://inspirehep.net/literature/1814793)
(SModelS of [ATLAS-SUSY-2018-04](https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2018-04/))
]

---
class: end-slide, center

.large[Backup]

---
# HistFactory Template

$$
f\left(\mathrm{data}\middle|\mathrm{parameters}\right) =  f\left(\vec{n}, \vec{a}\middle|\vec{\eta}, \vec{\chi}\right) = \color{blue}{\prod\_{c \\,\in\\, \textrm{channels}} \prod\_{b \\,\in\\, \textrm{bins}\_c} \textrm{Pois} \left(n\_{cb} \middle| \nu\_{cb}\left(\vec{\eta}, \vec{\chi}\right)\right)} \\,\color{red}{\prod\_{\chi \\,\in\\, \vec{\chi}} c\_{\chi} \left(a\_{\chi}\middle|\chi\right)}
$$

.bold[Use:] Multiple disjoint _channels_ (or regions) of binned distributions with multiple _samples_ contributing to each with additional (possibly shared) systematics between sample estimates

.kol-1-2[
.bold[Main pieces:]
- .blue[Main Poisson p.d.f. for simultaneous measurement of multiple channels]
- .katex[Event rates] $\nu\_{cb}$ (nominal rate $\nu\_{scb}^{0}$ with rate modifiers)
- .red[Constraint p.d.f. (+ data) for "auxiliary measurements"]
   - encode systematic uncertainties (e.g. normalization, shape)
- $\vec{n}$: events, $\vec{a}$: auxiliary data, $\vec{\eta}$: unconstrained pars, $\vec{\chi}$: constrained pars
]
.kol-1-2[
.center.width-100[[![SUSY-2016-16_annotated](figures/SUSY-2016-16.png)](https://atlas.web.cern.ch/Atlas/GROUPS/PHYSICS/PAPERS/SUSY-2016-16/)]
.center[Example: .bold[Each bin] is separate (1-bin) _channel_,<br> each .bold[histogram] (color) is a _sample_ and share<br> a .bold[normalization systematic] uncertainty]
]

---
# HistFactory Template

$$
f\left(\vec{n}, \vec{a}\middle|\vec{\eta}, \vec{\chi}\right) = \color{blue}{\prod\_{c \\,\in\\, \textrm{channels}} \prod\_{b \\,\in\\, \textrm{bins}\_c} \textrm{Pois} \left(n\_{cb} \middle| \nu\_{cb}\left(\vec{\eta}, \vec{\chi}\right)\right)} \\,\color{red}{\prod\_{\chi \\,\in\\, \vec{\chi}} c\_{\chi} \left(a\_{\chi}\middle|\chi\right)}
$$

Mathematical grammar for a simultaneous fit with

- .blue[multiple "channels"] (analysis regions, (stacks of) histograms)
- each region can have .blue[multiple bins]
- coupled to a set of .red[constraint terms]

.center[.bold[This is a _mathematical_ representation!] Nowhere is any software spec defined]
.center[.bold[Until now] (2018), the only implementation of HistFactory has been in [`ROOT`](https://root.cern.ch/)]

.bold[`pyhf`: HistFactory in pure Python]
.center.width-40[[![pyhf_PyPI](figures/pyhf_PyPI.png)](https://pypi.org/project/pyhf/)]

---
# What is `pyhf`?

Please checkout the many resources we have starting with the [website](https://scikit-hep.org/pyhf/) and the [SciPy 2020 talk](https://youtu.be/FrH9s3eB6fU)!

<!-- [![SciPy 2020 talk YouTube](http://i3.ytimg.com/vi/FrH9s3eB6fU/maxresdefault.jpg)](https://youtu.be/FrH9s3eB6fU) -->
<p align="center">
<a href="https://youtu.be/FrH9s3eB6fU"><img src="http://i3.ytimg.com/vi/FrH9s3eB6fU/maxresdefault.jpg" width="480" height="270"></a>
</p>
.grid[
.kol-1-3.center[
.width-60[[![scikit-hep_logo](https://scikit-hep.org/assets/images/logo.png)](https://scikit-hep.org/)]
]
.kol-1-3.center[
<br>
.width-60[[![pyhf_logo](https://iris-hep.org/assets/logos/pyhf-logo.png)](https://github.com/scikit-hep/pyhf)]
]
.kol-1-3.center[
<br>
.width-70[[![iris-hep_logo](assets/logos/logo_IRIS-HEP.png)](https://iris-hep.org/)]
]
]

---
# References

1. F. James, Y. Perrin, L. Lyons, .italic[[Workshop on confidence limits: Proceedings](http://inspirehep.net/record/534129)], 2000.
2. ROOT collaboration, K. Cranmer, G. Lewis, L. Moneta, A. Shibata and W. Verkerke, .italic[[HistFactory: A tool for creating statistical models for use with RooFit and RooStats](http://inspirehep.net/record/1236448)], 2012.
3. L. Heinrich, H. Schulz, J. Turner and Y. Zhou, .italic[[Constraining $A_{4}$ Leptonic Flavour Model Parameters at Colliders and Beyond](https://inspirehep.net/record/1698425)], 2018.
4. A. Read, .italic[[Modified frequentist analysis of search results (the $\\mathrm{CL}_{s}$ method)](http://cds.cern.ch/record/451614)], 2000.
5. K. Cranmer, .italic[[CERN Latin-American School of High-Energy Physics: Statistics for Particle Physicists](https://indico.cern.ch/event/208901/contributions/1501047/)], 2013.
6. ATLAS collaboration, .italic[[Search for bottom-squark pair production with the ATLAS detector in final states containing Higgs bosons, b-jets and missing transverse momentum](http://inspirehep.net/record/1748602)], 2019
7. ATLAS collaboration, .italic[[Reproducing searches for new physics with the ATLAS experiment through publication of full statistical likelihoods](https://cds.cern.ch/record/2684863)], 2019
8. ATLAS collaboration, .italic[[Search for bottom-squark pair production with the ATLAS detector in final states containing Higgs bosons, b-jets and missing transverse momentum: HEPData entry](https://www.hepdata.net/record/ins1748602)], 2019

---

class: end-slide, center
count: false

The end.
