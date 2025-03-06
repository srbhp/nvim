
FROM opensuse/leap
RUN zypper --non-interactive dup  
RUN zypper --non-interactive install git qt6-pdf-devel qt6-base-devel qt6-qml-devel neovim python3-neovim python3-pip
RUN pip install pynvim
RUN zypper --non-interactive install gcc-c++ make
RUN zypper --non-interactive install cmake
RUN zypper --non-interactive install ninja  
RUN zypper --non-interactive install python3-devel