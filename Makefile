# Optionally include some User preferences.
-include ~/commoncriteria/User.make
-include  User.make
DIFF_TAGS="v1.0"
TRANS?=transforms
# Include the Module Makefile
include $(TRANS)/module/Module.make

