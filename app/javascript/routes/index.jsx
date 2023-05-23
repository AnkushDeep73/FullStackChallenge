import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Borrowers from "../components/Borrowers";
import Borrower from "../components/Borrower";
import NewBorrower from "../components/NewBorrower";
import Invoice from "../components/Invoice";
import NewInvoice from "../components/NewInvoice";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/borrowers" element={<Borrowers />} />
      <Route path="/borrower" element={<NewBorrower />} />
      <Route path="/borrower/:id" element={<Borrower />} />
      <Route path="/borrower/:borrower_id/invoice" element={<NewInvoice />} />
      <Route path="/borrower/:borrower_id/invoice/:id" element={<Invoice />} />
    </Routes>
  </Router>
);