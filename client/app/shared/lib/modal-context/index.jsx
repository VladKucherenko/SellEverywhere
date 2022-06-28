import { Modal } from "../../ui";
import { createContext, memo, useContext, useState } from "react";

const noop = () => {};

const initialState = {
  showModal: noop,
  closeModal: noop,
  modalOpen: false,
  modalContent: null
};

const ModalContext = createContext(initialState);

export const useModalContext = () => useContext(ModalContext);

export const ModalContextProvider = memo(({ children }) => {
  const [modalOpen, setModal] = useState(false);

  const [modalContent, setModalContent] = useState(null);

  const showModal = (content = null) => {
    setModalContent(content);
    setModal(true);
  };

  const closeModal = () => setModal(false);

  return (
    <ModalContext.Provider
      value={{ modalOpen, modalContent, showModal, closeModal }}
    >
      <Modal />

      {children}
    </ModalContext.Provider>
  );
});

ModalContextProvider.displayName = "ModalContextProvider";
