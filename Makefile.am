plugindir = $(libdir)/xmimsim-custom-detector-response

plugin_LTLIBRARIES = xmimsim-detector-response-ap3.la

xmimsim_detector_response_ap3_la_FCFLAGS = @OPENMP_FCFLAGS@ @libxmimsim_CFLAGS@
xmimsim_detector_response_ap3_la_SOURCES = xmimsim-detector-response-ap3.F90
xmimsim_detector_response_ap3_la_LDFLAGS = -module -avoid-version -shared -export-dynamic
xmimsim_detector_response_ap3_la_LIBADD = @libxmimsim_LIBS@
if OS_WINDOWS
xmimsim_detector_response_ap3_la_LDFLAGS += -no-undefined
endif

clean-local:
	rm -f xmimsim_detector_response_ap3.mod
