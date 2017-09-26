RESOURCES_DIR = ../api/resources
ANNOTATIONS_DIR = ../users_annotations
RESULTS_DIR = results

install :
	cd +GrabCut && $(MAKE) install

analyse :
	matlab -nodesktop -r "try main( '$(RESOURCES_DIR)', '$(ANNOTATIONS_DIR)', '$(RESULTS_DIR)' ); catch; end; quit"
