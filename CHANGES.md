CHANGES
===========
08-Aug-2018
-----------
* Fix bug in fetch-reads that caused it to be single-threaded.
* Drop hard-coded tmpdir for pbalign.
* Use OrderedSet/Dict in ovlp_to_graph, for reproducibility.
* Fix njobs for most tasks.
* Update hgap4_adapt, for smrtlink users who want to run Unzip on the result.
  * That should work with smrtlink-6.0 ("Kiwi" internally).

25-Jul-2018
-----------
* Dump all variants from Arrow (for falcon-phase).
* Median-filter for fasta files.
* Support bam2dexta.
* Minor fixes.
* Support more recent networkx-2.

09-Jul-2018
-----------
* Changes to Falcon deduplication.
* Better subreads-filtering (based on "median" read-lengths).
* Support for REPmask (up to 3 iterations).
* Lots of minor clean-up, including input-config checks.

04-May-2018
-----------
* May the Fourth be with you.
* Added TANmask (but not REPmask yet), so FALCON workflow has changed.
* Reduced peak memory of graphs_to_h_tigs_2 (no longer use preads4falcon.fasta directly)

16-Apr-2018
-----------
* Minor fixes for config-parsing.

11-Apr-2018
-----------
* Bug fixes in Unzip.
* Warnings for old .cfg settings.

06-Apr-2018
-----------
* Improvements to Unzip
* Fixes in edge cases of Falcon and Unzip
* Changes to workflow
  * These will require re-running Falcon from scratch one time, rather than resuming.
* Lots of minor bug-fixes
* Simplification to pypeflow job-submission
* Sync from thegenemyers upstream
