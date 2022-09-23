import React, { memo, useEffect, useRef } from "react";
import { createPortal } from "react-dom";
import Image from "next/image";

import { Flex } from "../Layouts";
import { useModalContext } from "../../lib";
import useOnClickOutside from "../../../features/use-on-click-outside";

import styles from "./styles.module.scss";

export const Modal = memo(() => {
  const { modalContent, closeModal, modalOpen } = useModalContext();
  const dismissRef = useRef();

  useOnClickOutside(dismissRef, closeModal, modalOpen);

  useEffect(() => {
    if (modalOpen) {
      document.body.classList.add("burger-opened");
    } else {
      document.body.classList.remove("burger-opened");
    }
  }, [modalOpen]);

  if (modalOpen) {
    return createPortal(
      <div className={styles.container}>
        <div className={styles.inner} ref={dismissRef}>
          <Flex
            direction="column"
            x="start"
            y="center"
            customStyles={styles.content}
          >
            {modalContent}
          </Flex>
          <div className={styles.close}>
            <Image
              alt="close"
              width={18}
              height={18}
              src="/images/close.svg"
              onClick={closeModal}
            />
          </div>
        </div>
      </div>,
      document.querySelector("#modal-root")
    );
  }

  return null;
});

Modal.displayName = "Modal";
